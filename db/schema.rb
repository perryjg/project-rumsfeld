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

ActiveRecord::Schema.define(:version => 20120425160314) do

  create_table "letters", :force => true do |t|
    t.string   "sender"
    t.string   "sender_title"
    t.string   "sender_organization"
    t.string   "sender_email"
    t.string   "recipient"
    t.string   "email"
    t.string   "title"
    t.string   "organization"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "final_text"
    t.integer  "user_id"
    t.integer  "request_type_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "letters", ["request_type_id"], :name => "index_letters_on_request_type_id"
  add_index "letters", ["user_id"], :name => "index_letters_on_user_id"

  create_table "request_types", :force => true do |t|
    t.string   "name"
    t.text     "template"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "title"
    t.string   "organization"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
