class Users::InvitationsController < Devise::InvitationsController

  private

  def after_accept_path_for(resource)
    '/events'
  end
end
