class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password])
  end

  def current_user_can_edit?(model)
    user_signed_in? &&
        (model.user == current_user || model.try(:event).present? && model.event.user == current_user)
  end

  def notify_subscribers(event, thing)
    all_emails = (event.subscriptions.pluck(:user_email) + [event.user.email]).uniq
    all_emails.delete(thing.user.email) if thing.user.present?

    all_emails.each do |mail|
      EventMailer.photo(event, thing, mail).deliver_later if thing.is_a? Photo
      EventMailer.comment(event, thing, mail).deliver_later if thing.is_a? Comment
    end
  end

  private

  def user_not_authorized
    flash[:alert] = t('pundit.not_authorized')
    redirect_to(request.referrer || root_path)
  end
end
