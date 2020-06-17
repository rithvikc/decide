class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def new
    @event = Event.new
    @cuisine_event = CuisineEvent.new
    @event.invitations.build
  end

  def index
    @events = Event.all
    @user = current_user
    @user_invitations = Invitation.where(user: @user)
  end

  def create
    @event = Event.new(event_params.except(:cuisine_event_ids))
    @event.decided = false
    if @event.save!
      cuisine_event_params(event_params)
    # @save_count == event_params[:cuisine_event_ids].count

      redirect_to new_event_invitation_path(@event)
    else
      render :new
    end
  end

  def show
    # @invitation = Invitation.new
    if @event.result
      redirect_to event_result_path(@event.result) and return
    else
      @markers = @event.invitations.map do |i|
        {
          lat: i.latitude,
          lng: i.longitude,
          # infoWindow: render_to_string(partial: "infowindow", locals: { flat: flat }),
          image_url: helpers.asset_url('map-user-blue.png')
        }
      end
    end
  end

  def invite
    @user = User.find_by({ email: email_params[:invite][:email].downcase })
    @event = Event.find(params[:event_id])
    if @user.present? && @user.email == current_user.email
      flash[:notice] = "You're already attending this event"
    elsif @event.users.include?(@user)
      flash[:notice] = "You've already invited #{@user.email}"
    elsif @user.present? && User.all.include?(@user)
      @user.last_event = @event.id
      @user.invite![email: @user.email, last_event: @event.id]
      event_channel
      flash[:notice] = "Your invitation has been sent!"
    else
      User.invite!(email: email_params[:invite][:email].downcase, last_event: @event.id)
      event_channel
      flash[:notice] = "Your invitation has been sent!"
    end
    # redirect_to event_path(@event)
  end

  private

  def cuisine_event_params(event_params)
    @save_count = 0
    event_params[:cuisine_event_ids].each do |id|
      @cuisine_event = CuisineEvent.new
      @cuisine = Cuisine.find(id.to_i)
      @cuisine_event.cuisine = @cuisine
      @cuisine_event.event = @event
      @cuisine_event.save!
      @save_count += 1
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_at, cuisine_event_ids: [])
  end

  def create_invitations
    @event = Event.find(params[:id])
    @invitation = Invitation.new
  end

  def email_params
    params.permit(invite: :email)
  end

  def event_channel
    EventChannel.broadcast_to(
      @event,
      render_to_string(partial: "shared/invited", locals: { event: @event })
    )
  end
end
