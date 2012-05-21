class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.string :orno
      t.string :reference
      t.datetime :appointment

      t.timestamps
    end
  end
end
