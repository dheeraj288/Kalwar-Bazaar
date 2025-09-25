class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      # Generate OTP
      resource.generate_otp(send_via: :email)

      # Store user ID temporarily in session for OTP verification
      session[:otp_user_id] = resource.id

      # Redirect to OTP page instead of auto-login
      redirect_to users_verify_otp_path, notice: "OTP sent to your email!"
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
