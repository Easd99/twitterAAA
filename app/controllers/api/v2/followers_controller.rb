module Api
    module V2
        class FollowersController < ActionController::Base
            before_action :set_user, only: [:show, :destroy]

            def index
            end
            def show
                @followings = Friendship.where(friend_user_id: @user.id)
                @nombres=[]
                @followings.each do |following|
                    @users = User.where(id: following.user_id)
                    @users.each do |user|
                        @nombres.push(user.username)
                    end
                end
                render json: @nombres
            end
            def create
            end
            def destroy
            end

            private
            def set_user
                @user = User.find(params[:id])
            end

        end
    end
end