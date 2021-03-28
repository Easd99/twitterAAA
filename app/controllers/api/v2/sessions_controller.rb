module Api
    module V2
        class SessionsController < Devise::SessionsController
            skip_before_action :verify_authenticity_token
            respond_to :json
            

            private
            def respond_with(resource, _opts = {})
                render json: resource

            end
            def respond_to_on_destroy
                user =  User.authenticateShow(user_param_email)
                if user.valid_password?(user_param_pass)
                    User.idk(user)
                end
                head :no_content
            end
            def user_param_email
                params.require(:email)
            end
            def user_param_pass
                params.require(:password)
            end

        end
    end
end