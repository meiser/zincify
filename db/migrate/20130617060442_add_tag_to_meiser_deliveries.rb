class AddTagToMeiserDeliveries < ActiveRecord::Migration
  def change
   add_column :meiser_deliveries, :tag, :string
   add_index :meiser_deliveries, :tag, :unique => false
  end
  
end
