class RenameUsersPhoneNumber < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :phone, :phone_number
  end
end
