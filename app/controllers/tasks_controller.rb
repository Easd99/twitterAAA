class TasksController < ApplicationController
    before_action :authenticate_user!

    def index
        @tasks = Task.where(user_id: current_user.id)
    end
    
    def show
        @task=Task.find(params[:id])
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
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to tasks_path, notice: "Tweet eliminado"
      end
    
    private
    
    def task_params
        params.require(:task).permit(:description, :user_id)
        
    end




end



