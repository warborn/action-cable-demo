module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if current_user = get_current_user
        current_user
      else
        reject_unauthorized_connection
      end
    end

    def get_current_user
      token = get_token
      return nil unless token

      Warden::JWTAuth::UserDecoder.new.call(token, :user, Warden::JWTAuth::EnvHelper.aud_header(Rails.env))
    end

    def get_token
      (request.params[:Authorization] || "").split(" ")[1]
    end
  end
end
