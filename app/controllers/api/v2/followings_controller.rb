module Api
    module V2
        class FollowingsController < ApiController
            before_action :set_user, only: [:show, :destroy]

            def index
                followings = current_user.friendships
                followingslist=[]
                followings.each do |following|
                    followingslist.push({"id" => following.id, "username" => following.username})
                end
                render json: followingslist
            end
            def show
                followings = @user.friendships
                followingslist=[]
                followings.each do |following|
                    followingslist.push({"id" => following.id, "username" => following.username})
                end
                render json: followingslist
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