class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super { |resource| LastLoginChangesJob.set(wait: 3.seconds).perform_later(resource) }
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end