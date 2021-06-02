module Api
    module V2
        class TweetsController < ApiController
            before_action :set_tweet, only: [:show, :destroy]
                
            def index
                tweets = Tweet.all
                # tweetsList = []
                # tweets.each do | tweet|
                #     if tweet.image.blob
                #         tweetObj = {
                #             id: tweet.id,
                #             description: tweet.description,
                #             user_id: tweet.user_id,
                #             created_at: tweet.created_at,
                #             updated_at: tweet.updated_at,
                #             user:{
                #                 id: tweet.user.id,
                #                 name: tweet.user.name,
                #                 username: tweet.user.username,
                #                 email: tweet.user.email
                #             },
                #             image: {
                #                 url: tweet.image.blob.service_url
                #             }

                #         }
                #     else
                #         tweetObj = {
                #             id: tweet.id,
                #             description: tweet.description,
                #             user_id: tweet.user_id,
                #             created_at: tweet.created_at,
                #             updated_at: tweet.updated_at,
                #             user:{
                #                 id: tweet.user.id,
                #                 name: tweet.user.name,
                #                 username: tweet.user.username,
                #                 email: tweet.user.email
                #             },
                #             image: {
                #                 url: nil
                #             }

                #         }
                #     end
                #     tweetsList.push(tweetObj)
                # end

                # render json: tweetsList
                #render json: { tweets: tweets} , include: {:user => {:only => [:id, :username, :name, :email]}, :image => {include: [:blob] } }
                #render json: { tweets: tweets} , include: {:user => {:only => [:id, :username, :name, :email]}, :image => {include: [:blob] } }
                render json:  tweets, include: {:user => {:only => [:id, :username, :name, :email]} }
            end

            def show
                #render json: { tweets: @tweet} , include: {:user => {:only => [:id, :username, :name, :email]} }
                render json: @tweet , include: {:user => {:only => [:id, :username, :name, :email]} }
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
                    render :json => {:error => "CAN'T DELETE THIS TWEET"}.to_json, :status => 403
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