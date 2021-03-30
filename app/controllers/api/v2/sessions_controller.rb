module Api
    module V2
        class SessionsController < Devise::SessionsController
            skip_before_action :verify_authenticity_token
            respond_to :json
            
            def create
              user = User.authenticateShow(user_param_email)
              unless user.blank?
                if user.valid_password?(user_param_pass)
                  token = user.generate_jwt
                  render :json => { "user" => user , "token" => token} .to_json
                else
                  render :json => {:error => "USER AND/OR PASSWORD INCORRECT"}.to_json, :status => 404
                end
              end
            end


            private
            def respond_to_on_destroy
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