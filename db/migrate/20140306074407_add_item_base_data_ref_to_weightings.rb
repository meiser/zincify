class AddItemBaseDataRefToWeightings < ActiveRecord::Migration
  def change
    add_column :weightings, :item_base_data_id, :integer
	add_index :weightings, :item_base_data_id
  end
end
