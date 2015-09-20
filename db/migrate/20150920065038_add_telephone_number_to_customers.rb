class AddTelephoneNumberToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :telephone, :string
  end
end
