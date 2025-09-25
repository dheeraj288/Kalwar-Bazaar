class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)

    # Generate OTP
    resource.generate_otp(send_via: :email)

    # Store user in session until OTP verified
    session[:otp_user_id] = resource.id

    redirect_to users_verify_otp_path
  end
end
