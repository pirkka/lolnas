class RemoveDayFromLunch < ActiveRecord::Migration
  def up
    remove_column :lunches, :day
  end

  def down
    add_column :lunches, :day, :date
  end
end
