# frozen_string_literal: true

<<<<<<< HEAD
=======
# This class is SessionsHelper
>>>>>>> 21891a0f2fefc7f3a69469307f46aa8d03321751
module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      log_in user if user&.authenticated?(:remember, cookies[:remember_token])
    end
  end

  def current_user? user
    user && user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

<<<<<<< HEAD
  def log_out
    forget(current_user)
    reset_session
  end

=======
>>>>>>> 21891a0f2fefc7f3a69469307f46aa8d03321751
  def remember user
    user.remember
    cookies.permanent.encrypted[:user_id]
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

<<<<<<< HEAD
=======
  def log_out
    forget(current_user)
    reset_session
  end

>>>>>>> 21891a0f2fefc7f3a69469307f46aa8d03321751
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
