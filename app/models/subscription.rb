class Subscription < ApplicationRecord  
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: Devise.email_regexp, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  validate :event_owner
  validate :email_is_free

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private
  def event_owner
    if user&.id == event&.user_id
      errors.add(:user, "не должен быть создателем события")
    end
  end

  def email_is_free
    if User.all.map(&:email).include? user_email
      errors.add(:email, "уже занят другим пользователем")
    end
  end
end
