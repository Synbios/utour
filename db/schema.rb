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

ActiveRecord::Schema.define(version: 20140227062327) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "email"
    t.string   "gender"
    t.string   "wechat_id"
    t.integer  "user_group_id"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "memory_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_class_id"
    t.boolean  "active"
    t.string   "type"
    t.integer  "sale_channel_id"
    t.string   "company_name"
    t.string   "qr_code_url"
    t.string   "open_id"
    t.string   "wechat_province"
    t.string   "wechat_city"
    t.string   "wechat_head_url"
    t.string   "portray_file_name"
    t.string   "portray_content_type"
    t.integer  "portray_file_size"
    t.datetime "portray_updated_at"
    t.string   "qr_code_file_name"
    t.string   "qr_code_content_type"
    t.integer  "qr_code_file_size"
    t.datetime "qr_code_updated_at"
  end

  create_table "activities", force: true do |t|
    t.integer  "day_id"
    t.string   "time"
    t.string   "active_type"
    t.integer  "site_id"
    t.integer  "image_id"
    t.string   "short_des"
    t.text     "full_des"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", force: true do |t|
    t.integer  "date_and_price_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_children"
    t.integer  "number_of_adults"
    t.string   "comment"
    t.integer  "price_id"
    t.integer  "agent_id"
    t.integer  "sale_id"
  end

  create_table "date_and_prices", force: true do |t|
    t.integer  "tour_id"
    t.date     "departure_date"
    t.date     "return_date"
    t.date     "visa_mailing_date"
    t.date     "ticket_issuing_date"
    t.decimal  "trade_price",         precision: 10, scale: 0
    t.decimal  "retail_price",        precision: 10, scale: 0
    t.boolean  "export"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_groups"
  end

  create_table "days", force: true do |t|
    t.integer  "tour_id"
    t.integer  "number"
    t.string   "accommodation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "breakfast"
    t.string   "lunch"
    t.string   "dinner"
    t.text     "itinerary"
    t.string   "title"
  end

  create_table "departures", force: true do |t|
    t.integer  "tour_id"
    t.date     "date"
    t.string   "visa_status"
    t.string   "notification"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_seats"
    t.integer  "sale_channel_id"
    t.integer  "account_id"
  end

  create_table "feature_tag_connections", force: true do |t|
    t.integer  "parent_tag_id"
    t.integer  "child_tag_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feature_tags", force: true do |t|
    t.string   "name"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_and_sites", force: true do |t|
    t.integer  "image_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "invitation_codes", force: true do |t|
    t.integer  "user_class_id"
    t.integer  "user_group_id"
    t.datetime "expire_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.integer  "issued_by"
    t.integer  "used_by"
    t.datetime "used_at"
    t.boolean  "cancelled"
    t.integer  "sale_channel_id"
  end

  create_table "prices", force: true do |t|
    t.integer  "departure_id"
    t.decimal  "price",           precision: 10, scale: 0
    t.integer  "sale_channel_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sale_agents", force: true do |t|
    t.integer  "sale_id"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sale_channel_maps", force: true do |t|
    t.integer  "up"
    t.integer  "down"
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sale_channels", force: true do |t|
    t.string   "name"
    t.string   "abb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  create_table "shelves", force: true do |t|
    t.string   "name"
    t.text     "rack"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", force: true do |t|
    t.string   "name"
    t.string   "short_des"
    t.text     "full_des"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tours", force: true do |t|
    t.string   "identifier"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "tour_group"
    t.string   "sale_state"
    t.string   "description"
    t.string   "tour_type"
    t.text     "include"
    t.text     "exclude"
    t.text     "transportations"
    t.text     "notes"
    t.text     "visa"
    t.integer  "sale_channel_id"
  end

  create_table "user_classes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_group_maps", force: true do |t|
    t.integer  "up"
    t.integer  "down"
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
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
