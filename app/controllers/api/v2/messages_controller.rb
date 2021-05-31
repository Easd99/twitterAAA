module Api
    module V2
        class MessagesController < ApiController
            before_action :setRecipient, only: [:create]


            def create

                exist = Friendship.find_friendship(@user.id, @current_user_id)
                message = setMessage
                unless exist.blank?
                    Message.create(user_id: @current_user_id,friend_user_id: @user.id, message: setMessage)
                    render json: {ok: "ok"}
                else
                    render json: {error: "Can't send messages to this user"}, status: 400
                end

                
            end


            def setRecipient
                @user=User.find(params[:id])
                rescue ActiveRecord::RecordNotFound
                render :json => {:error => "TWITT NOT FOUND"}.to_json, :status => 404
            end

            def setMessage
                params.require(:message)
            end

        end
    end
end