class Subscription < ApplicationRecord  
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: Devise.email_regexp, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  validate :event_owner, if: -> { user.present? }
  validate :email_is_free, if: -> { user.present? }

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
    errors.add(:user, I18n.t('views.subscriptions.error_owner')) if user == event.user
  end

  def email_is_free
    errors.add(:email, I18n.t('views.subscriptions.error_email')) unless User.exists?(email: user_email)
  end
end
