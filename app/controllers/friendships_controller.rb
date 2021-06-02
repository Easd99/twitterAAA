class FriendshipsController < ApplicationController
    before_action :set_user, only: [:destroy,:seguir]
    before_action :authenticate_user!

    def seguir
        Friendship.create(user_id: current_user.id, friend_user_id: @friend.id)
        redirect_to user_path(id: @friend.id)
    end

    def destroy
        Friendship.find_friendship(current_user.id, @friend.id).delete_all
        redirect_to user_path(id: @friend.id)
    end

    private
    def set_user
        @friend = User.find(params[:id])
    end

end

