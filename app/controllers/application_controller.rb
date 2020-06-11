class ApplicationController < ActionController::Base
  def after_sign_in_path_for
    # return the path based on resource
    dashboard_path
  end
end
