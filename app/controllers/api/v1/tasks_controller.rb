module Api
    module V1
        class TasksController < ApiController
                before_action :set_task, only: [:show, :destroy]
                
            def index
                if(current_user.blank?)
                    render :json => {:error => "UNAUTHORIZED"}.to_json, :status => 401
                  else
                    #@tasks = Ta    sk.where(user_id: current_user.id)
                    @tasks = Task.all
                    render json: @tasks
                end
            end
            

            def show
                if(current_user.blank?)
                    render :json => {:error => "UNAUTHORIZED"}.to_json, :status => 401
                else    
                    render json: @task   
                end 
            end
            
            def new
                @task = Task.new
            end 

            def create
                if(current_user.blank?)
                    render :json => {:error => "UNAUTHORIZED"}.to_json, :status => 404
                else
                    @task =Task.new(task_params)
                    @task.user_id = current_user.id
                    if @task.save
                        # redirect_to tasks_path #, notice: "Enviado"
                        render json: @task, status: :ok
                    else
                        #render :new
                        message_error = "CAN'T SAVE TWEET"
                        render :json => {:error => message_error}.to_json, :status => 400
                    end
                end
            end        

            
            def destroy
                if(current_user.blank?)
                    render :json => {:error => "UNAUTHORIZED"}.to_json, :status => 404
                else
                    if (@task.user_id == current_user.id)
                        @task.destroy
                        render :json => {:error => "NO CONTENT"}.to_json, :status => 204
                    else
                        render :json => {:error => "CAN'T DELETE THIS TWEET"}.to_json, :status => 404
                    end
                   
                end
            end
        
            private
            def set_task
                @task=Task.find(params[:id])
            end
            def task_params
                params.require(:task).permit(:description, :user_id)
            end
        end
    end
end