class EventMailer < ApplicationMailer

  helper_method :mailer_date_header

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "Новый комментарий @ #{event.title}"
  end

  def photo(event, photo, email)
    @photo = photo
    @event = event

    mail to: email, subject: "Новое фото @ #{event.title}"
  end

  def mailer_date_header(event)
    event.datetime >= Time.now ? (t 'event_mailer.comment.datetime') : (t 'event_mailer.comment.datetime_fail')
  end
end
