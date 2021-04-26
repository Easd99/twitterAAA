module Api
    module V2
        class FriendshipsController < ActionController::Base
            skip_before_action :verify_authenticity_token
            rescue_from ActiveRecord::RecordNotUnique, with: :render404
            before_action :set_user, only: [:show, :destroy]
            def index
                @users = User.all
                @nombres=[]
                @users.each do |user|
                    @idsYnames = []
                    @idsYnames.push(user.id)
                    @idsYnames.push(user.username)
                    @nombres.push(@idsYnames)
                end
                render json: @nombres


                # @users = User.all
                # hash = Hash[@users.map { |l| [:id, l.id] }]
                # render json: hash
            end
            def show
                @friendship = Friendship.new(user_id: User.find(2).id, friend_user_id: @friend.id)
                if @friendship.save
                    FriendshipMailer.new_follower(User.last, @friend).deliver_now
                    render json: @friend.username
                end
            end
            def create

            end
            def destroy
                Friendship.find_friendship(User.find(2).id, @friend.id).delete_all
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