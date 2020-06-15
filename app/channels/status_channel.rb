class StatusChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    event = Event.find(params[:id])
    stream_for event
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
