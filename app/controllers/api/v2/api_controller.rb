module Api
    module V2
        class ApiController < ActionController::Base
                skip_before_action :verify_authenticity_token
                respond_to :json
                before_action :process_token
                rescue_from JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError, with: :render401

                private
              
                def process_token
                  if request.headers['Authorization'].present?
                    begin
                      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[0], Rails.application.secrets.secret_key_base).first
                      @current_user_id = jwt_payload['id']
                      @current_user_id = jwt_payload['id']
                    end
                end
              end
              

                def authenticate_user!(options = {})
                  head :unauthorized unless signed_in?
                end
              
                def current_user
                  @current_user ||= super || User.find(@current_user_id)
                end
              
                
                def signed_in?
                  @current_user_id.present?
                end

                def render401
                  render :json => {:error => "UNAUTHORIZED  1"}.to_json, :status => 401
                end
        end
    end
end

