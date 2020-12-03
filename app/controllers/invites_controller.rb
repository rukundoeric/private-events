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
      @invite.invited!
      flash[:notice] = 'INVITATION IS SENT SUCCESSFULLY!'
    else
      flash[:alert] = 'SOMETHING WENT WRONG!.'
    end

    redirect_to invites_path(event_id: event.id)
  end

  def destroy
    event = Event.find(params[:event_id])
    invite = Invite.find(params[:id])

    if current_user == event.creator
      invite.destroy
    else
      inite.status = 'invited'
      invite.save
    end

    redirect_to invites_path(event_id: event.id)
  end

  def update
    event = Event.find(params[:event_id])
    invite = Invite.find_by(event_id: params[:event_id], user_id: current_user.id)

    if invite&.invited?
      invite.accepted!
      flash[:notice] = 'THANKS FOR ACCEPTING TO ANTEND THIS EVENT!'
    elsif invite&.accepted?
      invite.invited!
      flash[:notice] = 'YOU HAVE WITHDRAWN FROM ATTENDING THIS EVENT!'
    else
      flash[:alert] = 'SORRY, YOU ARE NOT INVITED TO THIS EVENT!'
    end
    redirect_to event_path(event)
  end
end
