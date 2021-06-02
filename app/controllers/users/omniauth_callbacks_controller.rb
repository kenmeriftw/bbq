class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    omniauth_provider
  end

  def vkontakte
    omniauth_provider
  end

  private
  def omniauth_provider
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    oauth_provider = request.env['omniauth.auth'].provider
    
    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind:oauth_provider)
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t('devise.omniauth_callbacks.failure', kind: oauth_provider, reason: 'authentication error')

      redirect_to root_path
    end
  end
end
