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
      redirect_to event_path(@invitation[:event_id])
    else
      render :new
    end
  end

  def show; end

  private

  def set_invitation
    @event = Event.find(params[:event_id])
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:location, :cuisine_id)
  end
end
