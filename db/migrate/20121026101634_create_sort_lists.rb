class CreateSortLists < ActiveRecord::Migration
  def change
    create_table :sort_lists do |t|
      t.integer :number
      t.string :description

      t.timestamps
    end
  end
end
