class TweetsController < ApplicationController
    
    before_action :set_tweet, only: [:show, :destroy]

    def index
        #@tweets = Tweet.where(user_id: current_user.id)
        @tweets = Tweet.all
    end
    
    def show        
    end

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet =Tweet.new(tweet_params)
        @tweet.user_id = current_user.id
        if @tweet.save
            redirect_to tweets_path #, notice: "Enviado"
        else
            render :new
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
        params.require(:tweet).permit(:description, :user_id)
    end




end


