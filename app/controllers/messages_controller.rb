class MessagesController < ApplicationController
    before_action :set_friend, only: [:create, :index]
    before_action :setToken, only: [:create, :index]
    before_action :authenticate_user!


    def index
        @messages = Message.where(user_id: current_user.id,friend_user_id: @friend.id).or(Message.where(user_id:@friend.id ,friend_user_id: current_user.id))
        @friend_id = @friend.id 
    end

    def create

        unless params[:token] == current_user.id
            message = Message.new(setMessage)
            message.user_id = current_user.id
            message.friend_user_id = params[:token]
            message.save
            redirect_to messages_path(id: params[:token])
        else

        end
    end

    private
    def set_friend

        if (params[:id])
            @friend = User.find(params[:id])
        else
            @friend = current_user
        end
    end
    def setMessage
        params.require(:message).permit(:message, :user_id, :friend_user_id)
    end
    def setToken
        params[:token]
    end
    

end