class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Redirect after sign up
  def after_sign_up_path_for(resource)
    root_path
  end

  # Redirect after sign in
  def after_sign_in_path_for(resource)
    # If OTP not verified, redirect to OTP verification page
    if resource.otp_verified?
      super # proceed normally
    else
      resource.generate_otp(send_via: :email) # send OTP
      users_verify_otp_path                   # redirect to OTP page
    end
  end

  # Strong parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :profile_image])
  end
end
