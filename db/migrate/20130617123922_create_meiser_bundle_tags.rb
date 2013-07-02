class CreateMeiserBundleTags < ActiveRecord::Migration
  def change
    create_table :meiser_bundle_tags do |t|
      t.string :barcode
	  t.references :deliver_reference
      t.timestamps
    end
	add_index :meiser_bundle_tags, :barcode, :unique => true
  end
end
