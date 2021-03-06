class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?
  require 'csv'

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:full_name, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:full_name, :email, :password, :current_password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:invite){ |u| u.permit(:full_name, :email)}
    devise_parameter_sanitizer.permit(:accept_invitation){ |u| u.permit(:full_name, :password, :password_confirmation, :invitation_token)}
  end

end
