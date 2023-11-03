class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :surname, :has_equipment])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :surname, :has_equipment])
  end
end
