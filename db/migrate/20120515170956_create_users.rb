class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email, :null => false, :default => ""
      t.integer :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.text :preferences
      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :login, :unique => true
  end
end

