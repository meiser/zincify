class CreateMeiserDeliveries < ActiveRecord::Migration
  def change
    create_table :meiser_deliveries do |t|
      t.string :commission
      t.date :indate
      t.date :outdate
      t.text :remarks
      t.timestamps
    end
    add_index :meiser_deliveries, :commission, :unique => true
  end
end
