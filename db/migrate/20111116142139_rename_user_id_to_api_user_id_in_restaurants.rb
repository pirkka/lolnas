class RenameUserIdToApiUserIdInRestaurants < ActiveRecord::Migration
  def self.up
    rename_column :restaurants, :user_id, :api_user_id
  end

  def self.down
    rename_column :restaurants, :api_user_id, :user_id
  end
end
