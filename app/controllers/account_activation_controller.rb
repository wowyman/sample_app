# frozen_string_literal: true

<<<<<<< HEAD
# this class is acc-actiation-control
=======
# This class is AccountActivationController
>>>>>>> 21891a0f2fefc7f3a69469307f46aa8d03321751
class AccountActivationController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
