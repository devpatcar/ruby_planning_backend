# frozen_string_literal: true

module Api
  module V1
    class AuthsController < ApplicationController
      skip_before_action :authenticate_user

      def create
        token_command = AuthenticateUserCommand.call(*params.slice(:user, :password).values)

        if token_command.success?
          render json: { token: token_command.result }
        else
          render json: { error: token_command.errors }, status: :unauthorized
        end
      end

      def register
        user = User.new(email: params[:email], password: params[:password])

        if user.save
          render json: { user: user }
        else
          render json: { error: user.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
