class AddZincToMeiserBundleTags < ActiveRecord::Migration
  def change
    add_column :meiser_bundle_tags, :zinc, :string
  end
end
