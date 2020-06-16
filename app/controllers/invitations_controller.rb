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
    unless @event.invitations.empty? || within_50km?(@invitation, @event)
      flash[:notice] = "Your location is too far away!"
      render :new and return
    end
    @invitation.status = "Confirmed"
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

  def within_50km?(invitation, event)
    coords_array = []
    result = Geocoder.search(invitation.location)
    result_coords = result.first.coordinates
    event.invitations.each do |i|
      coords_array << [i.latitude, i.longitude]
    end
    geo_center = Geocoder::Calculations.geographic_center(coords_array)
    if Geocoder::Calculations.distance_between(geo_center, result_coords) <= 100
      return true
    else
      return false
    end
  end
end
