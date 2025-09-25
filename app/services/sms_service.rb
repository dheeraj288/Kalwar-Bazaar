class SmsService
  include HTTParty
  base_uri 'https://2factor.in/API/V1'

  def self.send_otp(phone_number, otp)
    api_key = ENV['TWOFACTOR_API_KEY']
    # 2factor format: /{API_KEY}/SMS/{PHONE_NUMBER}/{OTP}
    url = "/#{api_key}/SMS/#{phone_number}/#{otp}"
    get(url)
  end
end
