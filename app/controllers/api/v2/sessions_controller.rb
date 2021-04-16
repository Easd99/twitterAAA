module Api
    module V2
        class SessionsController < Devise::SessionsController
            skip_before_action :verify_authenticity_token
            rescue_from JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError, with: :render401
            respond_to :json
              
            def create
              user = User.authenticateShow(user_param_email)
              unless user.blank?
                if (user.confirmed?)
                  if user.valid_password?(user_param_pass)
                    user.update_column(:jti, User.generate_jti)
                    token = user.generate_jwt(user.jti)
                    render :json => { "user" => user , "token" => token} .to_json
                  else
                    render :json => {:error => "USER AND/OR PASSWORD INCORRECT"}.to_json, :status => 404
                  end
                else
                  render :json => {:error => "NO CONFIRMADO"}.to_json, :status => 404
                end

              end
            end


            def respond_to_on_destroy
                authenticate_or_request_with_http_token do |token, _options|
                  jwt_payload = JWT.decode(token.split(' ')[0], Rails.application.secret_key_base).first
                  @current_user_id = jwt_payload['id']
                  User.revoke_jwt(jwt_payload, User.find(@current_user_id))
                  render :json => { "TOKEN" => "TOKEN ELIMINADO CORRECTAMENTE"} .to_json
                end
            end

            private
            
            def authenticate_user!(options = {})
              head :unauthorized unless signed_in?
            end
          
            def current_user
              @current_user ||= super || User.find(@current_user_id)
            end
          
            
            def signed_in?
              @current_user_id.present?
            end

            def user_param_email
                params.require(:email)
            end
            def user_param_pass
                params.require(:password)
            end
            def render401
              render :json => {:error => "UNAUTHORIZE"}.to_json, :status => 401
            end

        end
    end
end