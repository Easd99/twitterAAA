module Api
    module V2
        class ApiController < ActionController::Base
                skip_before_action :verify_authenticity_token
                respond_to :json
                before_action :auth
                rescue_from JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError, with: :render401
                rescue_from ActiveRecord::RecordNotFound, with: :render404

                private
              
                def auth
                    authenticate_or_request_with_http_token do |token, _options|
                      @jwt_payload = JWT.decode(token.split(' ')[0], Rails.application.secret_key_base).first
                      @id = @jwt_payload['id']
                    end
                    unless(User.jwt_revoked?(@jwt_payload, User.find(@id)))
                      @current_user_id = @id
                    else
                      @current_user_id = nil
                      render :json => {:error => "TOKEN EXPIRED"}.to_json, :status => 401
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
                  render :json => {:error => "UNAUTHORIZE"}.to_json, :status => 401
                end

                def render404
                  render :json => {:error => "TWITT NOT FOUND"}.to_json, :status => 204
              end
        end
    end
end

