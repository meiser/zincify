class AddScaleNumberToWeightings < ActiveRecord::Migration
  def change
	add_column :weightings, :scale_ident, :string
  end
end
