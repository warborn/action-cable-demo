class Summary
  attr_reader :summary

  def initialize(notifications)
    @summary = get_summary_from_notifications(notifications)
  end

  def to_h
    summary.to_h
  end

  def to_human_readable
    summary.map do |k, v|
      pluralized = v > 1 ? k.pluralize : k
      [k, "#{v} #{pluralized.capitalize}"]
    end.to_h
  end

  def get_summary_from_notifications(notifications)
    summary = {}
    notifications.each do |notification|
      key = notification.category
      summary[key] = (summary[key] || 0) + 1
    end
    summary
  end
end


class LastLoginChangesJob < ApplicationJob
  queue_as :default

  def perform(user)
    notifications = get_external_notifications(user)
    summary = get_summary_of_notifications(notifications)

    return if summary.empty?

    ActionCable.server.broadcast 'notifications_channel', {
      type: "summary",
      message: "Notifications received while you were gone",
      content: summary
    }
  end

  def get_external_notifications(user)
    Notification.where.not(user_id: user.id).where('created_at > ?', user.last_sign_in_at)
  end

  def get_summary_of_notifications(input)
    notifications = input.to_a
    Summary.new(input).to_human_readable
  end
end
