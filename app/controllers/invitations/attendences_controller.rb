class Invitations::AttendencesController < ApplicationController
  def destroy
    @event = Event.find(params[:event_id])
    current_user.set_status_for(@event, "Declined")
    event_channel
    redirect_to event_path(@event)
  end

  def create
    @event = Event.find(params[:event_id])
    current_user.set_status_for(@event, "Confirmed")
    event_channel
    redirect_to event_path(@event)
  end

  private

  def event_channel
    EventChannel.broadcast_to(
      @event,
      render_to_string(partial: "shared/invited", locals: { event: @event })
    )
  end
end
