class CreateWeightings < ActiveRecord::Migration
  def change
    create_table :weightings do |t|
      t.string :barcode
	  t.string :ref
	  t.references :sort_list
	  t.decimal :weight_netto, :precision => 8, :scale => 2
	  t.decimal :weight_brutto, :precision => 8, :scale => 2
	  t.decimal :weight_tara, :precision => 8, :scale => 2
      t.timestamps
    end
  end
end
