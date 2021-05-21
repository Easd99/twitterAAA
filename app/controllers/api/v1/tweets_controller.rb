module Api
    module V1
        class TweetsController < ApiController
            before_action :set_tweet, only: [:show, :destroy]
                
            def index
                if(current_user.blank?)
                    render :json => {:error => "UNAUTHORIZED"}.to_json, :status => 401
                  else
                    @tweets = Tweet.all   
                    render json: @tweets
                end
            end
            

            def show
                if(current_user.blank?)
                    render :json => {:error => "UNAUTHORIZED"}.to_json, :status => 401
                else    
                    render json: @tweet   
                end 
            end
            
            def new
                @tweet = Tweet.new
            end 

            def create
                if(current_user.blank?)
                    render :json => {:error => "UNAUTHORIZED"}.to_json, :status => 404
                else
                    @tweet =Tweet.new(tweet_params)
                    @tweet.user_id = current_user.id
                    if @tweet.save
                        # redirect_to tweets_path #, notice: "Enviado"
                        render json: @tweet, status: :ok
                    else
                        #render :new
                        message_error = "CAN'T SAVE TWEET"
                        render :json => {:error => message_error}.to_json, :status => 400
                    end
                end
            end        

            
            def destroy
                if(current_user.blank?)
                    render :json => {:error => "UNAUTHORIZED"}.to_json, :status => 404
                else
                    if (@tweet.user_id == current_user.id)
                        @tweet.destroy
                        render :json => {:error => "NO CONTENT"}.to_json, :status => 204
                    else
                        render :json => {:error => "CAN'T DELETE THIS TWEET"}.to_json, :status => 404
                    end
                   
                end
            end
        
            private
            def set_tweet
                @tweet=Tweet.find(params[:id])
            end
            def tweet_params
                params.require(:tweet).permit(:description, :user_id)
            end
        end
    end
end