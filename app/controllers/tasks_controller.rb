class TasksController < ApplicationController
    
    before_action :set_task, only: [:show, :destroy]

    def index
        #@tasks = Task.where(user_id: current_user.id)
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
            render :new
        end
    end


    def destroy
        @task.destroy
        redirect_to tasks_path, notice: "Tweet eliminado"
      end
    
    private
    
    def set_task
        @task=Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:description, :user_id)
    end




end



