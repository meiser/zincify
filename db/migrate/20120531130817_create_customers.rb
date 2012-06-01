class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :bpid
      t.string :name
      t.text :address

      t.timestamps
    end
  end
end

