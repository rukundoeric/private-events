class InvitesController < ApplicationController
  before_action :require_login, except: %i[index]

  def index
    @users = User.all
  end

  def create
    user_id = params[:user_id]
    event = Event.find(params[:event_id])
    @invite = Invite.new(event_id: event.id, user_id: user_id)

    if @invite.save
      invite.invited!
      flash[:notice] = 'INVITATION IS SENT SUCCESSFULLY!'
      redirect_to users_path(event_id: event.id)
    else
      flash[:alert] = 'SOMETHING WENT WRONG!.'
      redirect_to event_path(event.id)
    end
  end

  def destroy
    event = Event.find(params[:event_id])
    invite = Invite.find(params[:id])

    if current_user == event.creator
      invite.destroy
      redirect_to users_path(event_id: event.id, id: invite.id)
    else
      inite.status = 'invited'
      invite.save
      redirect_to event_path(event)
    end
  end

  def update
    event = Event.find(params[:event_id])
    invite = Invite.find_by(event_id: params[:event_id], user_id: current_user.id)

    if invite&.invited
      invite.accepted!
      flash[:notice] = 'THANKS FOR ACCEPTING TO ANTEND THIS EVENT!'
    end
    redirect_to event_path(event)
  end
end
