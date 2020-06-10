class NotificationsController < ApplicationController

  def create
    notification = NotificationsHelper.create_notification(params[:notification])

      if notification
        ActionCable.server.broadcast 'notifications_channel', notification
      end

    render status: :created
  end

end
