class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def new
    @event = Event.new
    @cuisine_event = CuisineEvent.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def show; end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_at)
  end

end
