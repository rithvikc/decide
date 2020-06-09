class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def new
    @event = Event.new
    @cuisine_event = CuisineEvent.new
  end

  def create
    @event = Event.new(event_params.except(:cuisine_event_ids))
    @cuisine = Cuisine.find(cuisine_event_params(event_params))
    @cuisine_event = CuisineEvent.new
    @cuisine_event.cuisine = @cuisine

    if @event.save
      @cuisine_event.event = @event
      @cuisine_event.save!
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def show; end

  private

  def cuisine_event_params(event_params)
    # refactor for multiple ID's each
    event_params[:cuisine_event_ids][1].to_i
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_at, cuisine_event_ids: [])
  end

end
