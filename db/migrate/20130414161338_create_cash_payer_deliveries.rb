class CreateCashPayerDeliveries < ActiveRecord::Migration
  def change
    create_table :cash_payer_deliveries do |t|
      t.string :commission
	  t.string :custom_name
	  t.string :tag
      t.date :indate
      t.date :outdate
      t.text :remarks
      t.references :cash_payer
      t.timestamps
    end
    add_index :cash_payer_deliveries, :commission, :unique => true
  end
end
