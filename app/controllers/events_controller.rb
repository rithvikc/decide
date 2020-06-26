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
    unless event_params[:cuisine_event_ids].present?
      flash[:alert] = "Please pick a type of food!"
      redirect_to new_event_path and return
    end
    @event = Event.new(event_params.except(:cuisine_event_ids))
    @event.decided = false
    if @event.save
      cuisine_event_params(event_params)
      redirect_to new_event_invitation_path(@event)
    else
      render :new
    end
  end

  def show
    # @invitation = Invitation.new
    @user = current_user
    @invitation = @user.invitations.find_by(event: @event)
    if @event.result
      redirect_to event_result_path(@event, @event.result) && return
    else
      @markers = @event.invitations.where(status: "Confirmed").map do |i|
        {
          lat: i.latitude,
          lng: i.longitude,
          infoWindow: i.user.email[0].capitalize,
          # infoWindow: render_to_string(partial: "infowindow", locals: { flat: flat }),
          image_url: helpers.asset_url('map-user-blue.png')
        }
      end
    end
  end

  def invite
    @user = User.find_by({ email: email_params[:invite][:email].downcase })
    @event = Event.find(params[:event_id])
    if @user.present? && @user.email == current_user.email.downcase
      flash[:alert] = "You're already attending this event"
    elsif @event.users.include?(@user) || @event.users_pending_invitation.include?(@user)
      flash[:alert] = "You've already invited #{@user.email}"
    elsif @user.present?
      @user.last_event = @event.id
      @user.invite!
      flash[:alert] = "Your invitation has been sent!!!"
      event_channel
    else
      flash[:alert] = "Your invitation has been sent!"
      User.invite!(email: email_params[:invite][:email].downcase, last_event: @event.id)
      @event.reload
      event_channel
    end
    redirect_to event_path(@event)
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
