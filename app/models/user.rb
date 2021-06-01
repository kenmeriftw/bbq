class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]

  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length: {maximum: 35}

  before_validation :set_name, on: :create
  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  private

  def set_name
    self.name = "User#{rand(777)}" if name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end
  
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
