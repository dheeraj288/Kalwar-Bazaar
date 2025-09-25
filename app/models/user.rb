class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  # Generate OTP
  def generate_otp(send_via: :email)
    otp = rand(100000..999999).to_s
    update!(
      otp_code: otp,
      otp_sent_at: Time.current,
      otp_verified: false
    )

    case send_via
    when :email
      OtpMailer.otp_email(self).deliver_later
    when :sms
      SmsService.send_otp(phone_number, otp)
    end
  end

  # Check if OTP is valid
  def otp_valid?(entered_otp)
    return false if otp_code != entered_otp
    return false if otp_sent_at.blank? || otp_sent_at < 10.minutes.ago
    true
  end

  # Helper
  def otp_verified?
    otp_verified
  end
end
