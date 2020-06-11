class ApplicationController < ActionController::Base

  def after_sign_in_path_for
    # return the path based on resource
    dashboard_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit :accept_invitation, keys: [:email]
  end
end
