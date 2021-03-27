module Api
    module V1    
        class UsersController < ApplicationController
            skip_before_action :verify_authenticity_token
            rescue_from ActionController::ParameterMissing, with: :render404
            rescue_from ActiveRecord::RecordInvalid, with: :render404
            
            def index
                user = User.authenticateShow(user_param_mail)
                unless user.blank?
                    if user.valid_password?(user_param_pass)
                        if user.confirmed?
                            render json: user, status: :ok
                        else
                            message_error = "UNCONFIRMED EMAIL"
                            render :json => {:error => message_error}.to_json, :status => 401
                        end
                    else
                        render :json => {:error => "USER AND/OR PASSWORD INCORRECT"}.to_json, :status => 404
                    end
                          
                else
                    message_error = "USER NOT FOUND"
                    render :json => {:error => message_error}.to_json, :status => 404
                end
            end 

            def create
                user_data = {
                    :username => params[:username],
                    :name => params[:name],
                    :email => params[:email],
                    :password => params[:password],
                    :password_confirmation => params[:password_confirmation]
                }
                @user = User.create!(user_data)
                if @user.save
                    message = "AN EMAIL WAS SENT WITH A VERFICATION LINK"
                    render :json => {"CONFIRM" => message}.to_json, :status => 201
                else
                    message_error = "COULD NOT BE REGISTERED"
                    render :json => {:error => message_error}.to_json, :status => 422
                end
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
            def render404
                render :json => {:error => "SOME OF THE DATA HAS ALREADY BEEN TAKEN"}.to_json, :status => 400
            end
        end
    end
end
