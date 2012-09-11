class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.string :ref
      t.integer :user_id
      t.decimal :weight, :precision => 8, :scale => 2
      t.timestamps
    end
  end
end

