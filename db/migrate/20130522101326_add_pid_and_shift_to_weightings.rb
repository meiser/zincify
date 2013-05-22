class AddPidAndShiftToWeightings < ActiveRecord::Migration
  def change
	add_column :weightings, :pid, :string
	add_column :weightings, :shift, :string
  end
end
