class AddTelephoneNumberToCashPayers < ActiveRecord::Migration
  def change
    add_column :cash_payers, :telephone, :string
  end
end
