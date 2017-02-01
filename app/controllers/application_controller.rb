class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :notice, :alert
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar, :profile, :position, :occupation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:remember_me])
  end
end
