class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :delivery_id
      t.integer :traverse_id
      t.text :remarks
      t.text :pk
      t.timestamps
    end
  end
end

