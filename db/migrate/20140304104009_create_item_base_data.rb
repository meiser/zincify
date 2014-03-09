class CreateItemBaseData < ActiveRecord::Migration
  def change
    create_table :item_base_data do |t|
      t.string :item
      t.string :description

      t.timestamps
    end
  end
end
