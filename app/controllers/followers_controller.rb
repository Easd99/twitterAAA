class FollowersController < ApplicationController
    # before_action :set_user, only: [:show, :destroy]

    def index
        followers = Friendship.where(friend_user_id: current_user.id)
        @followerslist=[]
        followers.each do |follower|
            users = User.where(id: follower.user_id)
            users.each do |user|
                @followerslist.push({"id" => user.id, "username" => user.username})
            end
        end
        
    end
    # def show
    #     followers = Friendship.where(friend_user_id: @user.id)
    #     followerslist=[]
    #     followers.each do |follower|
    #         @users = User.where(id: follower.user_id)
    #         @users.each do |user|
    #             followerslist.push({"id" => user.id, "username" => user.username})
    #         end
    #     end
    #     render json: followerslist
    # end

    # def create
    # end
    # def destroy
    # end

    private
    # def set_user
    #     @user = User.find(params[:id])
    # end

end