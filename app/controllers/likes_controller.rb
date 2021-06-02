class LikesController < ApplicationController
    before_action :set_tweet, only: [:create, :destroy]
    before_action :setID, only: [:create, :destroy]
    before_action :indexID, only: [:create, :destroy]

    def create
        Like.create(user_id: current_user.id , tweet_id: @tweet.id )

        if setID 
            redirect_to tweet_path(setID)
        else
            if indexID
                redirect_to user_path(indexID)
            else
                redirect_to tweets_path
            end
        end
        
    end

    def destroy
        like = Like.where('user_id = ? and tweet_id = ?',current_user.id, @tweet.id).first
        like.destroy

        if setID 
            redirect_to tweet_path(setID)
        else
            if indexID
                redirect_to user_path(indexID)
            else
                redirect_to tweets_path
            end
        end
    end

    private
    def set_tweet
        @tweet=Tweet.find(params[:id])
    end

    def setID
        params[:rID]
    end

    def indexID
        params[:index_id]
    end

end