class RemoveTwoFactorFieldsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :otp_secret, :string
    remove_column :users, :consumed_timestep, :integer
    remove_column :users, :otp_plain, :string
    remove_column :users, :encrypted_otp_secret, :string
    remove_column :users, :encrypted_otp_secret_iv, :string
    remove_column :users, :encrypted_otp_secret_salt, :string
    remove_column :users, :otp_required_for_login, :boolean
    remove_column :users, :otp_attempts_count, :integer
    remove_column :users, :otp_session_id, :string
  end
end
