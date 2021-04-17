module Api
    module V2
        class FriendshipsController < ActionController::Base
            skip_before_action :verify_authenticity_token
            rescue_from ActiveRecord::RecordNotUnique, with: :render404
            before_action :set_user, only: [:show, :destroy]
            def index

            end
            def show
                @friendship = Friendship.new(user_id: User.last.id, friend_user_id: @friend.id)
                if @friendship.save
                    render json: @friend.username
                end
            end
            def create

            end
            def destroy
                Friendship.find_friendship(User.first.id, @friend.id).delete_all
                render :json => {:error => "NO CONTENT"}.to_json, :status => 204
            end

            private
            def set_user
                @friend = User.find(params[:id])
            end
            def render404
                render :json => {:error => "YA LO SIGUES"}.to_json, :status => 404
            end
        end
    end
end