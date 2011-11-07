class ChangeLunchTitleTypeToText < ActiveRecord::Migration
  def up
    change_column :lunches, :title, :text
  end

  def down
    change_column :lunches, :title, :string
  end
end
