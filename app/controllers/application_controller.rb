class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  before_action :set_current_user

  private

  def set_current_user
    @current_user ||= warden.authenticate(scope: :user)
  end
end
