class CreateDeliverReferences < ActiveRecord::Migration
  def change
    create_table :deliver_references do |t|
      t.string :name
      t.text :content
      t.integer :delivery_id
      t.timestamps
    end
  end
end

