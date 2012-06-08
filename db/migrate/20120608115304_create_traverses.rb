class CreateTraverses < ActiveRecord::Migration
  def change
    create_table :traverses do |t|
      t.string :name
      t.text :remarks

      t.timestamps
    end
  end
end
