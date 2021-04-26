module Api
    module V2
        class TimelinesController < ApiController
            
            #before_action :set_tweet, only: [:show]    
        #class TimelineController < ApiController
        
            def index
                if(current_user.blank?)
                    render :json => {:error => "UNAUTHORIZED"}.to_json, :status => 401
                  else 
                    @tweets = Tweet.where(user_id: current_user.friendships).or(Tweet.where(user_id: current_user.id))
                    render json: @tweets
                  end
                #render json: User.first.friendships.
            end

            # def show
            #     if @tweet.user_id ==  User.first.friendships
            #         render json: @tweet   
            #     end
            # end


            private
            # def set_tweet
            #     @tweet=Tweet.find(params[:id])
            # end


        end
    end
end
