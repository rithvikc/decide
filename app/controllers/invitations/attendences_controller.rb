class Invitations::AttendencesController < ApplicationController
  def destroy
    @event = Event.find(params[:event_id])
    current_user.set_status_for(@event, "Cancelled")
    redirect_to event_path(@event)
  end

  def create
    @event = Event.find(params[:event_id])
    current_user.set_status_for(@event, "Confirmed")
    redirect_to event_path(@event)
  end
end
