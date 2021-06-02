class TimelinesController < ApplicationController
    before_action :authenticate_user!

    def index
        @tweets = Tweet.where(user_id: current_user.friendships).or(Tweet.where(user_id: current_user.id))
    end

end