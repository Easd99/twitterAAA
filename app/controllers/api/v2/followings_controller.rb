module Api
    module V2
        class FollowingsController < ApiController
            before_action :set_user, only: [:show, :destroy]

            def index
            end
            def show
                @followers = @user.friendships
                @nombres=[]
                @followers.each do |follower|
                    @nombres.push(follower.username)
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