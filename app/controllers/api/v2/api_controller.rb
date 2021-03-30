module Api
    module V2
        class ApiController < ActionController::Base
            skip_before_action :verify_authenticity_token
            before_action :check_basic_auth
            rescue_from ActiveRecord::RecordNotFound, with: :render404

            def check_basic_auth
                authenticate_or_request_with_http_token do |token, _options|
                    user =  User.find_by(jti: token)
                    unless user.blank?
                        if user.confirmed?
                            @current_user = user
                        else
                            render :json => {:error => "UNCONFIRMED EMAIL"}.to_json, :status => 401
                        end
                         
                    else
                        render :json => {:error => "TOKEN INCORRECTO"}.to_json, :status => 422
                    end
                end
            end


            private
            def current_user
                @current_user
            end
            def render404
                render :json => {:error => "TWITT NOT FOUND"}.to_json, :status => 204
            end
        end
    end
end

