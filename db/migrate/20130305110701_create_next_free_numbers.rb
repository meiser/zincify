class CreateNextFreeNumbers < ActiveRecord::Migration
  def change
    create_table :next_free_numbers do |t|
      t.string :no
      t.text :description
      t.integer :fifo
	  t.text :content
      t.timestamps
    end
  end
end
