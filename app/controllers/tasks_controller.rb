class TasksController < ApplicationController
    before_action :authenticate_user!

    def index
        @tasks = Task.all 
    end


    def new
        @task = Task.new

    end

    def create
        @task =Task.new(task_params)
        if @task.save
            redirect_to tasks_path, notice: "Enviado"
        else
            reder :new
        end
    end
    
    private
    
    def task_params
        params.require(:task).permit(:description)
    end


end



