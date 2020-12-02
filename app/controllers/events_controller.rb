class EventsController < ApplicationController
  before_action :require_login, except: [:index]

  def index
    @upcoming_events = Event.upcoming
    @prev_events = Event.past
  end

  def new
    @event = current_user.events.build
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:success] = "EVENT '#{@event.name.upcase}' CREATE SUCCESSFULLY!"
      redirect_to @event
    else
      flash[:error] = 'SOMETHING WENT WRONG!'
      render 'new'
    end
  end
end
