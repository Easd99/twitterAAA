class UsersController < ApplicationController
    before_action :setUser, only: [:show]
    before_action :authenticate_user!


    def show
        @tweets = Tweet.where(user_id: @user.id )
    end

    private
    def setUser
        @user = User.find(params[:id])
    end
end