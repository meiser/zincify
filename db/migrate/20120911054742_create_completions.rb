class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.string :ref
      t.integer :user_id
	  t.integer :sort_list_id
      t.decimal :weight_netto, :precision => 8, :scale => 2
	  t.decimal :weight_brutto, :precision => 8, :scale => 2
	  t.decimal :weight_tara, :precision => 8, :scale => 2
      t.timestamps
    end
  end
end

