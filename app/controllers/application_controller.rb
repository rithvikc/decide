class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])

    # For additional in app/views/devise/registrations/edit.html.erb
    # Code from lecture: devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end

  protected

  # def after_sign_in_path_for(resource)
  #   # return the path based on resource
  #   '/home'
  # end
end
