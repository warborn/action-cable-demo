module NotificationsHelper
  ALERT_MESSAGES = [
    "An assault is happening in your area",
    "A robbery has occurred in your neighborhood",
    "There will be a blockage in your area today",
    "An accident happened on the road"
  ]

  def self.create_notification(notification)
    method_name = "create_#{notification[:type]}_notification".to_sym
    if NotificationsHelper.respond_to?(method_name)
      notification_content = NotificationsHelper.method(method_name).call()
      Notification.create({category: notification[:type], **notification_content})
    else
      nil
    end
  end

  private

  def self.create_alert_notification
    {message: ALERT_MESSAGES.sample}
  end

  def self.create_activity_notification
    {message: "Some of your dashboard's data has been updated"}
  end

  def self.create_download_notification
    {message: "Your file is ready to download"}
  end
end