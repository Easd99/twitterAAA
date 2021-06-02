class LikesController < ApplicationController
    before_action :set_tweet, only: [:create, :destroy]

    def create
        Like.create(user_id: current_user.id , tweet_id: @tweet.id )
        redirect_to tweets_path
    end

    def destroy
        like = Like.where('user_id = ? and tweet_id = ?',current_user.id, @tweet.id).first
        like.destroy
        redirect_to tweets_path
    end

    private
    def set_tweet
        @tweet=Tweet.find(params[:id])
    end

end