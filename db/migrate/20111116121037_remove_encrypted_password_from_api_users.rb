class RemoveEncryptedPasswordFromApiUsers < ActiveRecord::Migration
  def up
    change_table :api_users do |t|
      t.remove :encrypted_password
    end
  end

  def down
    change_table :api_users do |t|
      t.string :encrypted_password, :limit => 128, :default => "", :null => false
    end
  end
end
