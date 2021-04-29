module Api
    module V2
        class FriendshipsController < ApiController
            rescue_from ActiveRecord::RecordNotUnique, with: :render404
            before_action :set_user, only: [:show, :destroy,:seguir]
            def index
                users = User.all
                userslist=[]
                users.each do |user|
                    userslist.push({"id" => user.id, "username" => user.username})
                end
                render json: userslist
                # @users = User.all
                # hash = Hash[@users.map { |l| [:id, l.id] }]
                # render json: hash
            end
            
            def show
            end

            def seguir
                unless current_user.id == @friend.id
                    friendship = Friendship.new(user_id: current_user.id, friend_user_id: @friend.id)
                    if friendship.save
                        FriendshipMailer.new_follower(current_user, @friend).deliver_now
                        friendhash = {"id" => @friend.id, "username" => @friend.username}
                        render json: friendhash
                    end
                else
                    render :json => {:error => "NO TE PUEDES SEGUIR A TI "}.to_json, :status => 404
                end
            end

            def create

            end
            def destroy
                Friendship.find_friendship(current_user.id, @friend.id).delete_all
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