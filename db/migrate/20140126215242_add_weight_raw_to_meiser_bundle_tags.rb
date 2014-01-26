class AddWeightRawToMeiserBundleTags < ActiveRecord::Migration
  def change
    add_column :meiser_bundle_tags, :weight_raw, :decimal, :precision => 8, :scale => 2
    add_column :meiser_bundle_tags, :info, :text
  end
end
