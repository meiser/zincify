class CreateNextFreeNumbers < ActiveRecord::Migration
  def change
    create_table :next_free_numbers do |t|
      t.string :name
      t.string :prefix
      t.integer :next_id
      t.boolean :year_prefix
      t.boolean :month_prefix
      t.boolean :day_prefix
      t.integer :length
      t.timestamps
    end
  end
end
