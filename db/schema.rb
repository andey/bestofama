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

ActiveRecord::Schema.define(version: 20130803205601) do

  create_table "amas", force: true do |t|
    t.string   "key",                    null: false
    t.datetime "date",                   null: false
    t.string   "title",                  null: false
    t.text     "content"
    t.integer  "karma",      default: 0
    t.integer  "user_id",                null: false
    t.string   "permalink"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "comments",   default: 0
    t.integer  "responses",  default: 0
  end

  add_index "amas", ["key"], name: "index_amas_on_key", unique: true, using: :btree

  create_table "amas_users", id: false, force: true do |t|
    t.integer "ama_id"
    t.integer "user_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "ama_id",                 null: false
    t.string   "key",                    null: false
    t.integer  "user_id",                null: false
    t.text     "content"
    t.string   "parent_key",             null: false
    t.datetime "date",                   null: false
    t.integer  "karma",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "comments", ["key"], name: "index_comments_on_key", using: :btree

  create_table "meta", force: true do |t|
    t.string   "name",       null: false
    t.string   "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meta", ["name"], name: "index_meta_on_name", unique: true, using: :btree

  create_table "ops", force: true do |t|
    t.string   "name",                            null: false
    t.string   "content"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "slug",                            null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "wikipedia_hits",      default: 0
    t.integer  "link_karma",          default: 0
    t.integer  "comment_karma",       default: 0
  end

  add_index "ops", ["slug"], name: "index_ops_on_slug", unique: true, using: :btree

  create_table "ops_links", force: true do |t|
    t.integer  "op_id"
    t.integer  "site_id"
    t.string   "link",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ops_users", id: false, force: true do |t|
    t.integer "op_id"
    t.integer "user_id"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.integer  "karma"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.string  "description"
    t.string  "wikipedia_url"
    t.boolean "meaningless"
  end

  create_table "trashes", force: true do |t|
    t.string   "key",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "trashes", ["key"], name: "index_trashes_on_key", unique: true, using: :btree

  create_table "upcomings", force: true do |t|
    t.string   "title"
    t.datetime "date"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",                  null: false
    t.integer  "comment_karma", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "link_karma",    default: 0
  end

  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
