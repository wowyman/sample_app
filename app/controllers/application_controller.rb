# frozen_string_literal: true

# This class is ApplicationController
class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = "Access Denied"
    redirect_to root_path
  end

  def logged_in_user
    return if user_signed_in?

    store_location
    flash[:danger] = "Please login."
    redirect_to login_url
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
