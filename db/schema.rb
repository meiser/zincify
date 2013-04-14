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

ActiveRecord::Schema.define(:version => 20130414161802) do

  create_table "cash_payer_deliveries", :force => true do |t|
    t.string   "commission"
    t.date     "indate"
    t.date     "outdate"
    t.text     "remarks"
    t.integer  "cash_payer_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "cash_payer_deliveries", ["commission"], :name => "index_cash_payer_deliveries_on_commission", :unique => true

  create_table "cash_payers", :force => true do |t|
    t.string   "addresscode"
    t.string   "name"
    t.text     "address"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "customer_deliveries", :force => true do |t|
    t.string   "commission"
    t.date     "indate"
    t.date     "outdate"
    t.text     "remarks"
    t.integer  "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "customer_deliveries", ["commission"], :name => "index_customer_deliveries_on_commission", :unique => true

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

  create_table "meiser_deliveries", :force => true do |t|
    t.string   "commission"
    t.date     "indate"
    t.date     "outdate"
    t.text     "remarks"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "meiser_deliveries", ["commission"], :name => "index_meiser_deliveries_on_commission", :unique => true

  create_table "next_free_numbers", :force => true do |t|
    t.string   "name"
    t.string   "prefix"
    t.integer  "next_id"
    t.boolean  "year_prefix"
    t.boolean  "month_prefix"
    t.boolean  "day_prefix"
    t.integer  "length"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
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
