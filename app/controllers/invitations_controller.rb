class InvitationsController < ApplicationController
before_action :set_invitation, only: [:show]

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      redirect_to invitation_path(@invitation)
    else
      render :new
    end

  end

  def show; end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:name, :description, :start_at)
  end



end
