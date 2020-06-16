class Users::InvitationsController < Devise::InvitationsController

  # def create
  #   raise
  #   self.resource = invite_resource
  #   if resource.errors.empty?
  #     if params[:user][:widget_id].present?
  #       set_flash_message :notice, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
  #       Permission.create(user_id: resource.id, widget_id: params[:user][:widget_id], subject_class: 'Widget', role_ids: params[:role_id])
  #     else
  #       set_flash_message :notice, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
  #     end
  #     respond_with resource, :location => after_invite_path_for(:back)
  #   else
  #     set_flash_message :notice, :send_instructions, :email => self.resource.email
  #     Permission.create(user_id: resource.id, widget_id: params[:user][:widget_id], subject_class: 'Widget', role_ids: params[:role_id])
  #     respond_with resource, :location => after_invite_path_for(:back)
  #   end
  # end

  private

  def after_accept_path_for(resource)
    new_event_invitation_path(Event.find(resource.last_event))
  end
end
