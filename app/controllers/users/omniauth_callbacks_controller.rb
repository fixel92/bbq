class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      right_redirect(@user)
    else
      flash[:error] = I18n.t(
          'devise.omniauth_callbacks.failure',
          kind: 'Facebook',
          reason: 'authentication error'
      )

      redirect_to root_path
    end
  end
  def vkontakte
    @user = User.find_for_vkontakte_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      right_redirect(@user)
    else
      flash[:error] = I18n.t(
          'devise.omniauth_callbacks.failure',
          kind: 'Vkontakte',
          reason: 'authentication error'
      )

      redirect_to root_path
    end
  end

  private

  def right_redirect(user)
    if user.email.nil?
      flash[:notice] = I18n.t('controllers.users.omniauth_callbacks.success_no_email')
      sign_in @user, event: :authentication

      redirect_to edit_user_path(@user)
    else
      flash[:notice] = I18n.t('controllers.users.omniauth_callbacks.success_with_email')
      sign_in_and_redirect @user, event: :authentication
    end
  end
end