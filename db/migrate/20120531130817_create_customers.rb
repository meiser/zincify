class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :bpid
      t.string :name
      t.text :address

      t.timestamps
    end
    add_index :customers, :name
    add_index :customers, :bpid
  end
end

