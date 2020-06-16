class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show]

  def new
    @event = Event.find(params[:event_id])
    @invitation = Invitation.new
  end

  def create
    @event = Event.find(params[:event_id])
    @invitation = Invitation.new(invitation_params)
    @user = current_user
    @invitation.user = @user
    @invitation.event = @event
    if @invitation.save
      EventChannel.broadcast_to(
        @event,
        render_to_string(partial: "shared/invited", locals: { event: @event })
      )
      redirect_to event_path(@invitation[:event_id])
    else
      render :new
    end
  end

  def show; end

  private

  def set_invitation
    @event = Event.find(params[:event_id])
    @invitation = Invitation.new
    # @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:location, :cuisine_id)
  end
end
