class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? 

  

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || tweets_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :name])
  end


end

  

