class TweetsController < ApplicationController
    
    before_action :set_tweet, only: [:show, :destroy]
    before_action :authenticate_user!
    
    def index
        #@tweets = Tweet.where(user_id: current_user.id)
        @tweets = Tweet.all
    end
    
    def show        
    end

    def create
        @tweet =Tweet.new(tweet_params)
        @tweet.user_id = current_user.id
        if @tweet.save
            redirect_to tweets_path #, notice: "Enviado"
        else
            redirect_to new_tweet_path
        end
    end


    def destroy
        @tweet.destroy
        redirect_to tweets_path, notice: "Tweet eliminado"
    end
    
    private
    
    def set_tweet
        @tweet=Tweet.find(params[:id])
    end

    def tweet_params
        params.require(:tweet).permit(:description, :user_id, :image)
    end




end



