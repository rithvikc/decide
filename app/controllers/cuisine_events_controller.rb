class CuisineEventsController < ApplicationController
  def create
    raise
    @event = Event.find(params[:event_id])
    @cuisine = Cuisine.find(params[:cuisine_event][:cuisine_id])
    @cuisine_event = Cuisine_event.new(cuisine_event_params)
    @cuisine_event.cuisine = @cuisine
    @cuisine_event.event = @event
    if @cuisine_event.save!
      redirect_to event_path(@event)
    else
      render 'events/new'
    end
  end

end
