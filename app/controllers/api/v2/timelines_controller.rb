module Api
    module V2
        class TimelinesController < ApiController
            
            #before_action :set_task, only: [:show]    
        #class TimelineController < ApiController
        
            def index
                if(current_user.blank?)
                    render :json => {:error => "UNAUTHORIZED"}.to_json, :status => 401
                  else 
                    @tasks = Task.where(user_id: current_user.friendships)
                    render json: @tasks
                  end
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
