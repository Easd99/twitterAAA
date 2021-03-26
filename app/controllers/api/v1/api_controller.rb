module Api
    module V1
        class ApiController < ActionController::Base
            skip_before_action :verify_authenticity_token
            before_action :check_basic_auth
            rescue_from ActiveRecord::RecordNotFound, with: :render404

            def check_basic_auth

                authenticate_with_http_basic do |email, user_token|
                    user =  User.authenticate(email,user_token)
                    unless user.blank?
                            @current_user = user
                    else
                        head :unauthorized
                    end
                end
            end


            private
            def current_user
                @current_user
            end

            def render404
                render :json => {:error => "TWITT NO ENCONTRADO"}.to_json, :status => 400
            end
        end
    end
end

