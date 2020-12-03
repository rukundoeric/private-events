class EventsController < ApplicationController
  before_action :require_login, except: [:index]

  include EventsHelper

  def index
    @upcoming_events = Event.upcoming
    @prev_events = Event.past
  end

  def new
    @event = current_user.events.build
  end

  def show
    @event = Event.find(params[:id])
    @invitees = User.find(@event.invites.invited.map(&:user_id))
    @attendies = User.find(@event.invites.accepted.map(&:user_id))
    @is_attendy = current_user.invites.accepted.select { |obj| obj[:event_id] == @event.id }.any?
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      @invite = Invite.new(event_id: @event.id, user_id: current_user.id)
      @invite.invited!
      @invite.accepted!
      flash[:success] = "EVENT '#{@event.name.upcase}' CREATE SUCCESSFULLY!"
      redirect_to event_path(@event)
    else
      flash[:error] = 'SOMETHING WENT WRONG!'
      render 'new'
    end
  end
end
