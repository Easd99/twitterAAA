module Api
    module V1    
        class UsersController < ApplicationController
            skip_before_action :verify_authenticity_token
            rescue_from ActionController::ParameterMissing, with: :render404

            def index
                user = User.authenticateShow(user_param_mail, user_param_pass)
                unless user.blank?
                    render json: user, status: :ok
                # redirect_to tasks_path #, notice: "Enviado"
                    
                else
                    #render :new
                    message_error = "USER NOT FOUND"
                    render :json => {:error => message_error}.to_json, :status => 404
                end
            end 

            def create

            end

            private
            def user_param_mail
                params.require(:email)
            end
            def user_param_pass
                params.require(:password)
            end
            def render404
                render :json => {:error => "INVALID SYNTAX"}.to_json, :status => 400
            end
        end
    end
end
