class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.integer :customer_id
	  t.integer :cash_payer_id
      t.string :commission
      t.string :reference
      t.date :indate
      t.date :outdate
      t.text :remarks
      t.timestamps
    end
    add_index :deliveries, :commission, :unique => true
  end

end

