class CreatePrinters < ActiveRecord::Migration
  def change
    create_table :printers do |t|
      t.string :ident
      t.text :description

      t.timestamps
    end
  end
end
