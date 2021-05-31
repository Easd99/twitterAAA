module Api
    module V2
        class LikesController < ApiController
            before_action :set_tweet, only: [:show, :create, :destroy]

            def show
                cantLikes = @tweet.likes.length
                render json:{likes: cantLikes}
            end   
            
            def create
                already = Like.where('user_id = ? and tweet_id = ?',@current_user_id, @tweet.id).first
                if already.blank?
                    Like.create(user_id: @current_user_id , tweet_id: @tweet.id )
                end
                render json:{ok: 'ok'}
            end

            def destroy
                already = Like.where('user_id = ? and tweet_id = ?',@current_user_id, @tweet.id).first
                unless already.blank?
                    already.destroy
                end
                render json:{ok: 'ok'}
            end

            private
            def set_tweet
                @tweet=Tweet.find(params[:id])
                rescue ActiveRecord::RecordNotFound
                render :json => {:error => "TWETT NOT FOUND"}.to_json, :status => 404
            end
        end
    end
end