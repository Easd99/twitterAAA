module Api
    module V2
        class RegistrationsController < Devise::RegistrationsController
            rescue_from ActiveRecord::RecordInvalid, with: :render404
            skip_before_action :verify_authenticity_token
            respond_to :json  

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
            def render404
                render :json => {:error => "SOME OF DATA HAS ALREADY TAKEN"}.to_json, :status => 422
            end
        end
    end
end
