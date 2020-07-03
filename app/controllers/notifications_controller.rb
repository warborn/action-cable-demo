class NotificationsController < ApplicationController

  def create
    notification = NotificationsHelper.create_notification(params[:notification])

    if notification
      @current_user.notifications << notification
      ActionCable.server.broadcast 'notifications_channel', notification.to_h
    end

    render status: :created
  end

end
