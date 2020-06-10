class NotificationsController < ApplicationController

  def create
    notification = NotificationsHelper.create_notification(params[:notification])

    render status: :created
  end

end
