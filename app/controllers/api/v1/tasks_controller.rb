module Api
    module V1
        class TasksController < ApiController
                before_action :set_task, only: [:show, :destroy]
                before_action :check_basic_auth
                def index
                    #@tasks = Ta    sk.where(user_id: current_user.id)
                    @tasks = Task.all
                    render json: @tasks
                end

                def show    
                    render json: @task    
                end
            
                def new
                    @task = Task.new
                end
            
                def create
                    @task =Task.new(task_params)
                    @task.user_id = current_user.id
                    if @task.save
                       # redirect_to tasks_path #, notice: "Enviado"
                        render json: @task, status: :ok
                    else
                        #render :new
                        message_eror = "No se envio el twitt"
                        render :json => {:error => message_error}.to_json, :status => 400
                    end
                end
            
            
                def destroy
                    @task.destroy
                    head :no_content
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