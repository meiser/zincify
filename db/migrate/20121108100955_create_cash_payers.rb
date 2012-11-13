class CreateCashPayers < ActiveRecord::Migration
  def change
    create_table :cash_payers do |t|
      t.string :addresscode
      t.string :name
      t.text :address

      t.timestamps
    end
  end
end
