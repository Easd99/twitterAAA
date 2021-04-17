module Api
    module V2
        class TimelinesController < ActionController::Base
            #before_action :set_task, only: [:show]    
        #class TimelineController < ApiController
        
            def index
                @tasks = Task.where(user_id: User.find(1).friendships)
                render json: @tasks
                #render json: User.first.friendships.
            end

            # def show
            #     if @task.user_id ==  User.first.friendships
            #         render json: @task   
            #     end
            # end


            private
            # def set_task
            #     @task=Task.find(params[:id])
            # end


        end
    end
end
