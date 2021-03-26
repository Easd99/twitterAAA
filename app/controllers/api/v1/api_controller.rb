module Api
    module V1
        class ApiController < ActionController::Base
            skip_before_action :verify_authenticity_token
            before_action :check_basic_auth

            def check_basic_auth
                #params[:email] paramas[:password]
                authenticate_with_http_basic do |email, password|
                    user = User.find_by_name(email)
                    if !user.nil? && User.authenticate(email,password)
                        @current_user = user  
                    else
                      head :unauthorized
                    end  

                end 
            end    
        end
    end
end

