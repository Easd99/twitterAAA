class ApplicationController < ActionController::Base

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_in) do |user_params|
          user_params.permit(:username, :email)
        end
      end



end
