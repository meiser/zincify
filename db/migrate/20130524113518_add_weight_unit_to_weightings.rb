class AddWeightUnitToWeightings < ActiveRecord::Migration
  def change
  	add_column :weightings, :weight_unit, :string
  end
end
