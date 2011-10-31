class CreateLunches < ActiveRecord::Migration
  def change
    create_table :lunches do |t|
      t.string :title
      t.float :price
      t.integer :restaurant_id
      t.date :day
      t.timestamps
    end
  end
end
