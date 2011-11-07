class AddValidFromAndValidUntilToLunch < ActiveRecord::Migration
  def change
    add_column :lunches, :valid_from, :datetime
    add_column :lunches, :valid_until, :datetime
  end
end
