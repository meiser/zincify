class CreatePrintTriggers < ActiveRecord::Migration
  def change
    create_table :print_triggers do |t|
      t.text :printer
      t.text :label
      t.text :data
      t.integer :printed, :default => 0

      t.timestamps
    end
  end
end
