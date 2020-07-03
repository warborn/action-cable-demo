class Notification < ApplicationRecord
  include ActiveModel::Serializers::JSON

  belongs_to :user

  def to_h
    {type: self.category, message: self.message}
  end
end
