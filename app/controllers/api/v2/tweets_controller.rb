module Api
    module V2
        class TweetsController < ApiController
            before_action :set_tweet, only: [:show, :destroy]
                
            def index
                @tweets = Tweet.all
                render json: @tweets
            end

            def show
                render json: @tweet   
            end
            
            # def new
            #     @tweet = Tweet.new
            # end 

            def create
                @tweet =Tweet.new(tweet_params)
                @tweet.user_id = current_user.id
                if @tweet.save
                    render json: @tweet, status: :ok
                else
                    message_error = "CAN'T SAVE TWEET"
                    render :json => {:error => message_error}.to_json, :status => 400
                end
            end        

            
            def destroy
                if (@tweet.user_id == current_user.id)
                    @tweet.destroy
                    render :json => {:error => "NO CONTENT"}.to_json, :status => 204
                else
                    render :json => {:error => "CAN'T DELETE THIS TWEET"}.to_json, :status => 404
                end
            end
        
            private
            def set_tweet
                @tweet=Tweet.find(params[:id])
                rescue ActiveRecord::RecordNotFound
                render :json => {:error => "TWITT NOT FOUND"}.to_json, :status => 404
            end
            
            def tweet_params
                params.require(:tweet).permit(:description, :user_id)
            end
        end
    end
end