module Api
    module V2
        class HashtagsController < ApiController

            def index 
                hashtag = "%#{setHashtag}%"
                if setHashtag.match(/[#][a-zA-Z0-9]/)
                    tweets = Tweet.where("description LIKE ? ", hashtag)
                    tweetsList = []
                    tweets.each do |tweet|
                        unless tweet.description.match(/#{setHashtag}[a-zA-Z]/)
                            tweetsList.push(tweet)
                        end
                    end
                    render json: {tweets: tweetsList}
                else
                    render json: {error: 'error'}, status: 404
                end
                
            end

            private
            def setHashtag
                params.require(:hashtag)
            end


        end
    end
end