class EventChannel < ApplicationCable::Channel
  def subscribed
    event = Event.find(params[:id])
    stream_for event
  end
end
