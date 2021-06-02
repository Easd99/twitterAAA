class HashtagsController < ApplicationController
    before_action :authenticate_user!

    def index 
        hashtag = "%#{setHashtag}%"
        tweetsList = []
        if setHashtag.match(/[#][a-zA-Z0-9]/)
            tweets = Tweet.where("description LIKE ? ", hashtag)
            tweets.each do |tweet|
                unless tweet.description.match(/#{setHashtag}[a-zA-Z]/) or tweet.description.match(/[a-zA-Z]#{setHashtag}/)
                    tweetsList.push(tweet)
                end
            end
            
        else
            
        end
        @tweets = tweetsList
        
    end

    private
    def setHashtag
        params.require(:hashtag)
    end


end