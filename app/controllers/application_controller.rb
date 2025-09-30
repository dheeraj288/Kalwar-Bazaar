class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_sign_in_path_for(resource)
    if resource.otp_verified?
      super 
    else
      resource.generate_otp(send_via: :email) 
      users_verify_otp_path                  
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :profile_image])
  end
end
