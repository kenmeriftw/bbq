class EventMailerJob < ApplicationJob
  queue_as :default

  def perform(event, object)
    all_emails = (event.subscribers.pluck(:email) + [event.user.email] - [object.user.email]).uniq

    case object
    when Photo
      all_emails.each do |mail|
        EventMailer.photo(event, object, mail).deliver_later
      end
    when Comment
      all_emails.each do |mail|
        EventMailer.comment(event, object, mail).deliver_later
      end
    when Subscription
      EventMailer.subscription(event, object).deliver_later
    end
  end
end
