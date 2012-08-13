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

ActiveRecord::Schema.define(:version => 20120723162854) do

  create_table "messages", :force => true do |t|
    t.integer "sender_id"
    t.integer "receiver_d"
    t.string  "mssage"
  end

  create_table "notifications", :force => true do |t|
    t.integer "receiver_id",     :null => false
    t.integer "sender_id",       :null => false
    t.integer "notifiable_id"
    t.string  "notifiable_type"
    t.integer "target_id"
    t.string  "target_type"
    t.boolean "apns"
    t.boolean "apn_processed"
    t.string  "type"
  end

  create_table "users", :force => true do |t|
    t.string "name"
    t.string "email"
    t.string "apn_device_token"
  end

end
