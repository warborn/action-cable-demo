module NotificationsHelper
  def self.create_notification(notification)
    method_name = "create_#{notification[:type]}_notification".to_sym
    if NotificationsHelper.respond_to?(method_name)
      notification_content = NotificationsHelper.method(method_name).call()
      {type: notification[:type], **notification_content}
    else
      nil
    end
  end

  private

  def self.create_alert_notification
    {message: "An assault is happening in your area"}
  end

  def self.create_activity_notification
    {message: "Some of your dashboard's data has been updated"}
  end

  def self.create_download_notification
    {message: "Your file is ready to download"}
  end
end