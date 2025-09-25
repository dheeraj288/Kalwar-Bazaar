class OtpMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'

  def otp_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your OTP Code')
  end
end
