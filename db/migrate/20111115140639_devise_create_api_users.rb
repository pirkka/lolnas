class DeviseCreateApiUsers < ActiveRecord::Migration
  def self.up
    create_table(:api_users) do |t|
      t.database_authenticatable :null => false
      #t.recoverable
      #t.rememberable
      t.trackable

      # t.encryptable
      t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      t.token_authenticatable
      t.confirmable

      t.timestamps
    end

    add_index :api_users, :email,                :unique => true
#    add_index :api_users, :reset_password_token, :unique => true
    add_index :api_users, :confirmation_token,   :unique => true
    # add_index :api_users, :unlock_token,         :unique => true
    add_index :api_users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :api_users
  end
end
