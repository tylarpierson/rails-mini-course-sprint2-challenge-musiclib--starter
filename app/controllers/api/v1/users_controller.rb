module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all

        render json: @users
      end

      def show
        @user = User.find(params[:id])

        render json: @user
      end

      def create
        @user = User.new(user_params)
        @user.api_key = DEFAULT_API_KEY

        if @user.save
          render json: @user, status: :created, location: api_v1_user_url(@user)
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email)
      end
    end
  end
end
