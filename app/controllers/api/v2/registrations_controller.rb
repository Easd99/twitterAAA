module Api
    module V2
        class RegistrationsController < Devise::RegistrationsController
            skip_before_action :verify_authenticity_token
            respond_to :json  

            def create
                build_resource(sign_up_params)
                if (resource.save)
                    render json: resource, status: :created
                else
                    message_error = "COULD NOT BE REGISTERED"
                    render :json => {:error => message_error}.to_json, :status => 422
                end
            end

            
            
        end
    end
end
