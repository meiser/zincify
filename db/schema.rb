# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130314102914) do

  create_table "bookings", :force => true do |t|
    t.integer  "delivery_id"
    t.integer  "traverse_id"
    t.text     "remarks"
    t.text     "pk"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cash_payers", :force => true do |t|
    t.string   "addresscode"
    t.string   "name"
    t.text     "address"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "commissions", :force => true do |t|
    t.string   "uid"
    t.integer  "delivery_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "completions", :force => true do |t|
    t.string   "ref"
    t.integer  "user_id"
    t.integer  "sort_list_id"
    t.decimal  "weight_netto",  :precision => 8, :scale => 2
    t.decimal  "weight_brutto", :precision => 8, :scale => 2
    t.decimal  "weight_tara",   :precision => 8, :scale => 2
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "bpid"
    t.string   "name"
    t.text     "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "customers", ["bpid"], :name => "index_customers_on_bpid"
  add_index "customers", ["name"], :name => "index_customers_on_name"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "deliver_references", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "delivery_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "deliveries", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "cash_payer_id"
    t.string   "commission"
    t.string   "reference"
    t.date     "indate"
    t.date     "outdate"
    t.text     "remarks"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "state"
  end

  add_index "deliveries", ["commission"], :name => "index_deliveries_on_commission", :unique => true

  create_table "next_free_numbers", :force => true do |t|
    t.string   "no"
    t.text     "description"
    t.integer  "fifo"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "print_triggers", :force => true do |t|
    t.text     "printer"
    t.text     "label"
    t.text     "data"
    t.integer  "printed",    :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "printers", :force => true do |t|
    t.string   "ident"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sort_lists", :force => true do |t|
    t.integer  "number"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "traverses", :force => true do |t|
    t.string   "name"
    t.text     "remarks"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.text     "preferences"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
