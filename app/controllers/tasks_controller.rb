class TasksController < ApplicationController
    before_action :authenticate_user!

    def index
        @tasks = Task.all 
    end
    
    def show
    end

    def new
        @task = Task.new
    end

    def create
        @task =Task.new(task_params)
        @task.user_id = current_user.id
        if @task.save
            redirect_to tasks_path #, notice: "Enviado"
        else
            reder :new
        end
    end
    
    private
    
    def task_params
        params.require(:task).permit(:description, :user_id)
        
    end




end



