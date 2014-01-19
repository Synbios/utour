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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140119142844) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "email"
    t.string   "gender"
    t.string   "wechat_id"
    t.integer  "user_group"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "memory_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "superuser"
  end

  create_table "bookings", force: true do |t|
    t.date     "departure_date"
    t.integer  "number_of_people"
    t.string   "package_id"
    t.integer  "tour_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tours", force: true do |t|
    t.string   "identifier"
    t.string   "name"
    t.string   "content"
    t.date     "departure_date"
    t.date     "return_date"
    t.date     "visa_mailing_date"
    t.date     "ticket_issuing_date"
    t.decimal  "trade_price",         precision: 10, scale: 0
    t.decimal  "retail_price",        precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "user_group_permission_hashes", force: true do |t|
    t.integer  "user_group_id"
    t.integer  "allowed_user_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
