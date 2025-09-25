class Users::OtpController < ApplicationController
  before_action :set_user_from_session

  # OTP page
  def new
    redirect_to root_path, notice: "Already verified!" if @user.otp_verified?
  end

  # Verify OTP
  def create
    if @user.otp_valid?(params[:otp_code])
      @user.update!(otp_verified: true)
      sign_in(@user) # Devise recognizes user now
      session.delete(:otp_user_id)
      redirect_to root_path, notice: "OTP verified successfully!"
    else
      flash.now[:alert] = "Invalid or expired OTP"
      render :new, status: :unprocessable_entity
    end
  end

  # Resend OTP
  def resend
    @user.generate_otp(send_via: params[:via]&.to_sym || :email)
    redirect_to users_verify_otp_path, notice: "OTP resent!"
  end

  private

  def set_user_from_session
    @user = User.find_by(id: session[:otp_user_id])
    redirect_to new_user_session_path, alert: "Sign in first!" unless @user
  end
end
