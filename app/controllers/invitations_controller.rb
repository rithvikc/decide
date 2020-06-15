class InvitationsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @invitation = Invitation.new(invitation_params)
    @invitation.event = @event
    @invitation.user = current_user
    if @invitation.save
      redirect_to event_path(@event, anchor: "invitation-#{@invitation.id}")
    else
      render "events/show"
    end
  end
end
