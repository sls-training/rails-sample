# frozen_string_literal: true

module Api
  class TokensController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    # POST /api/token
    def create
      email = params[:email]
      access_token = AccessToken.new(email:).encode
      render json: { access_token: }
    end

    private

    def authenticate_user!
      email = params[:email]
      password = params[:password]
      user = User.find_by(email:)
      return render_unauthorized unless user
      return render_forbidden unless user.admin

      render_unauthorized unless user.authenticate(password)
    end

    def render_forbidden
      errors = [{ name: 'access_token', message: t('.not_admin') }]
      render 'api/errors', status: :forbidden,
                           locals: { errors: }
    end

    def render_unauthorized
      errors = [{ name: 'access_token', message: t('.incorrect_input') }]
      render 'api/errors', status: :unauthorized,
                           locals: { errors: }
    end
  end
end
