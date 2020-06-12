class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :authenticate_user!, only: [:home]


  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit :accept_invitation, keys: [:email]
  end

  def after_sign_in_path_for(resource)
    # return the path based on resource
    '/dashboard'
  end
end
