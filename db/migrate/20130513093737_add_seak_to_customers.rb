class AddSeakToCustomers < ActiveRecord::Migration
  def change
   add_column :customers, :seak, :string
  end
end
