class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length: {maximum: 35}

  before_validation :set_name, on: :create
  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  private

  def self.find_for_facebook_oauth(access_token)
    email = access_token.info.email
    user = where(email: email).first

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id
    social_url = "https://facebook.com/#{id}"

    where(social_url: social_url, provider: provider).first_or_create! do |user|
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end
  end

  def self.find_for_vkontakte_oauth(access_token)
    email = access_token.info.email
    user = where(email: email).first

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id
    social_url = "https://vk.com/#{id}"

    where(social_url: social_url, provider: provider).first_or_create! do |user|
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end
  
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def set_name
    self.name = "User#{rand(777)}" if name.blank?
  end
end
