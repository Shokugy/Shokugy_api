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

ActiveRecord::Schema.define(version: 20151223212158) do

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "restaurant_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "favorites", ["restaurant_id"], name: "index_favorites_on_restaurant_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "group_users", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "group_users", ["group_id"], name: "index_group_users_on_group_id", using: :btree
  add_index "group_users", ["user_id"], name: "index_group_users_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",             limit: 255, null: false
    t.string   "crypted_password", limit: 255
    t.string   "salt",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

  create_table "invite_users", force: :cascade do |t|
    t.integer  "invite_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "invite_users", ["invite_id"], name: "index_invite_users_on_invite_id", using: :btree
  add_index "invite_users", ["user_id"], name: "index_invite_users_on_user_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.text     "text",          limit: 65535
    t.integer  "restaurant_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id",       limit: 4
    t.integer  "group_id",      limit: 4
  end

  add_index "invites", ["group_id"], name: "index_invites_on_group_id", using: :btree
  add_index "invites", ["restaurant_id"], name: "index_invites_on_restaurant_id", using: :btree
  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "rates", force: :cascade do |t|
    t.float    "rate",          limit: 24
    t.integer  "restaurant_id", limit: 4
    t.integer  "group_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "rates", ["group_id"], name: "index_rates_on_group_id", using: :btree
  add_index "rates", ["restaurant_id"], name: "index_rates_on_restaurant_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "name_kana",   limit: 255
    t.text     "link",        limit: 65535
    t.text     "image_url",   limit: 65535
    t.string   "postal_code", limit: 255
    t.text     "address",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "review",        limit: 65535
    t.float    "rate",          limit: 24
    t.integer  "restaurant_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "reviews", ["restaurant_id"], name: "index_reviews_on_restaurant_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "active_group_id", limit: 4
    t.string   "fb_id",           limit: 255
  end

  add_foreign_key "favorites", "restaurants"
  add_foreign_key "favorites", "users"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "invite_users", "invites"
  add_foreign_key "invite_users", "users"
  add_foreign_key "invites", "groups"
  add_foreign_key "invites", "restaurants"
  add_foreign_key "invites", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "rates", "groups"
  add_foreign_key "rates", "restaurants"
  add_foreign_key "reviews", "restaurants"
  add_foreign_key "reviews", "users"
end
