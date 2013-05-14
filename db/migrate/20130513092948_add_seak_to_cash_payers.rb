class AddSeakToCashPayers < ActiveRecord::Migration
  def change
   add_column :cash_payers, :seak, :string
  end
end
