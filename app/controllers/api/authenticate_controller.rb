# frozen_string_literal: true

module Api
  class AuthenticateController < ApiController
    before_action :require_access_token

    protected

    def require_access_token
      access_token = request.headers['Authorization']
      return render json: { message: t(:missing_token) }, status: :unauthorized if access_token.nil?

      begin
        AccessToken.from_token(access_token[7..])
      rescue JWT::DecodeError
        render json: { message: t(:invalid_token) }, status: :unauthorized
      end
    end
  end
end
