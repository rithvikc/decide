class Users::InvitationsController < Devise::InvitationsController

  private

  def after_accept_path_for(resource)
    new_event_invitation_path(Event.find(resource.last_event))
  end
end
