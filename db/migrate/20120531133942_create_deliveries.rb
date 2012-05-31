class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.integer :customer_id
      t.string :reference
      t.date :deadline

      t.timestamps
    end
  end
end
