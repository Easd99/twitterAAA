module Api
    module V2
        class HashtagsController < ApiController



            def index 
                hashtag = "%#{setHashtag}%"
                tweets = Tweet.where("description LIKE ? ", hashtag)
                tweetsList = []
                sw = false
                tweets.each do |tweet|
                    descripSpl = tweet.description.split(' ')
                    descripSpl.each do |palabra|
                        if (palabra.casecmp(setHashtag) == 0)
                            sw = true
                        end
                    end
                    if sw == true
                        tweetsList.push(tweet)
                        sw = false
                    end

                end

                render json: {tweets: tweetsList}
            end

            private
            def setHashtag
                params.require(:hashtag)
            end


        end
    end
end