class TasksController < ApplicationController
    before_action :authenticate_user!
    def index
        @tasks = Task.all 
    end
    def show

    end

    def new

    end


end
