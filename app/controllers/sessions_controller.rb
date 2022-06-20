# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # log user
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to forwarding_url || user
      else
        message = 'Account not activated. '
        message += 'Check your email for the activation link.'
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def google_auth
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
      access_token = auth
      u.google_token = auth.credentials.token
      refresh_token = auth.credentials.refresh_token
      u.google_refresh_token = refresh_token if refresh_token.present?
      u.password = SecureRandom.urlsafe_base64
    end
    log_in @user
    redirect_to menu_path
  end

  def create_facebook
    user = User.from_omniauth(request.env['omniauth.auth'])
    log_in user
    redirect_to user
  end

  def auth
    request.env['omniauth.auth']
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
