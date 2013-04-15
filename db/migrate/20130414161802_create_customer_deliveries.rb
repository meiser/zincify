class CreateCustomerDeliveries < ActiveRecord::Migration
  def change
    create_table :customer_deliveries do |t|
      t.string :commission
	  t.string :tag
      t.date :indate
      t.date :outdate
      t.text :remarks
      t.references :customer
      t.timestamps
    end
    add_index :customer_deliveries, :commission, :unique => true
  end
end
