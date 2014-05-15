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

ActiveRecord::Schema.define(version: 20140405031313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

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

  add_index "amas", ["date"], name: "index_amas_on_date", using: :btree
  add_index "amas", ["key"], name: "index_amas_on_key", unique: true, using: :btree

  create_table "amas_users", id: false, force: true do |t|
    t.integer "ama_id"
    t.integer "user_id"
  end

  add_index "amas_users", ["ama_id", "user_id"], name: "index_amas_users_on_ama_id_and_user_id", unique: true, using: :btree

  create_table "archives", force: true do |t|
    t.integer  "ama_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "json"
  end

  add_index "archives", ["ama_id"], name: "index_archives_on_ama_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "ama_id",                         null: false
    t.string   "key",                            null: false
    t.integer  "user_id",                        null: false
    t.text     "content"
    t.string   "parent_key",                     null: false
    t.datetime "date",                           null: false
    t.integer  "karma",          default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "relevant",       default: false
    t.boolean  "relevant_child", default: false
  end

  add_index "comments", ["ama_id"], name: "index_comments_on_ama_id", using: :btree
  add_index "comments", ["key"], name: "index_comments_on_key", using: :btree
  add_index "comments", ["parent_key"], name: "index_comments_on_parent_key", using: :btree
  add_index "comments", ["relevant"], name: "index_comments_on_relevant", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "meta", force: true do |t|
    t.string   "name",       null: false
    t.string   "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meta", ["name"], name: "index_meta_on_name", unique: true, using: :btree

  create_table "ops", force: true do |t|
    t.string   "name",                            null: false
    t.text     "content"
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
    t.string   "avatar_source"
  end

  add_index "ops", ["slug"], name: "index_ops_on_slug", unique: true, using: :btree
  add_index "ops", ["wikipedia_hits", "comment_karma", "link_karma", "name"], name: "ops_sortable_columns", using: :btree

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

  add_index "ops_users", ["op_id", "user_id"], name: "index_ops_users_on_op_id_and_user_id", unique: true, using: :btree

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

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "wikipedia_url"
    t.boolean  "meaningless"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_source"
    t.string   "redirect_tag_name"
    t.integer  "redirect_tag_id"
    t.datetime "updated_at",         default: '2014-01-26 02:53:37'
    t.integer  "taggings_count",     default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

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
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "upcomings", ["date"], name: "index_upcomings_on_date", using: :btree

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
