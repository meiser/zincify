class AddRankingToSortList < ActiveRecord::Migration
  def change
	add_column :sort_lists, :ranking, :integer
  end
end
