# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_01_06_020916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace", limit: 255
    t.text "body"
    t.string "resource_id", limit: 255, null: false
    t.string "resource_type", limit: 255, null: false
    t.integer "author_id"
    t.string "author_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "amas", id: :serial, force: :cascade do |t|
    t.string "key", limit: 255, null: false
    t.datetime "date", null: false
    t.string "title", limit: 255, null: false
    t.text "content"
    t.integer "karma", default: 0
    t.integer "user_id", null: false
    t.string "permalink", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comments", default: 0
    t.integer "responses", default: 0
    t.index ["date"], name: "index_amas_on_date"
    t.index ["key"], name: "index_amas_on_key", unique: true
  end

  create_table "amas_users", id: false, force: :cascade do |t|
    t.integer "ama_id"
    t.integer "user_id"
    t.index ["ama_id", "user_id"], name: "index_amas_users_on_ama_id_and_user_id", unique: true
  end

  create_table "archives", id: :serial, force: :cascade do |t|
    t.integer "ama_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore "json"
    t.index ["ama_id"], name: "index_archives_on_ama_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "ama_id", null: false
    t.string "key", limit: 255, null: false
    t.integer "user_id", null: false
    t.text "content"
    t.string "parent_key", limit: 255, null: false
    t.datetime "date", null: false
    t.integer "karma", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "relevant", default: false
    t.boolean "relevant_child", default: false
    t.index ["ama_id"], name: "index_comments_on_ama_id"
    t.index ["key"], name: "index_comments_on_key"
    t.index ["parent_key"], name: "index_comments_on_parent_key"
    t.index ["relevant"], name: "index_comments_on_relevant"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "meta", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "value", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_meta_on_name", unique: true
  end

  create_table "ops", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", limit: 255, null: false
    t.string "avatar_file_name", limit: 255
    t.string "avatar_content_type", limit: 255
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "wikipedia_hits", default: 0
    t.integer "link_karma", default: 0
    t.integer "comment_karma", default: 0
    t.string "avatar_source", limit: 255
    t.index ["slug"], name: "index_ops_on_slug", unique: true
    t.index ["wikipedia_hits", "comment_karma", "link_karma", "name"], name: "ops_sortable_columns"
  end

  create_table "ops_links", id: :serial, force: :cascade do |t|
    t.integer "op_id"
    t.integer "site_id"
    t.string "link", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ops_users", id: false, force: :cascade do |t|
    t.integer "op_id"
    t.integer "user_id"
    t.index ["op_id", "user_id"], name: "index_ops_users_on_op_id_and_user_id", unique: true
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type", limit: 255
    t.integer "tagger_id"
    t.string "tagger_type", limit: 255
    t.string "context", limit: 128
    t.datetime "created_at"
    t.integer "karma"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.string "wikipedia_url", limit: 255
    t.boolean "meaningless"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "image_source", limit: 255
    t.string "redirect_tag_name", limit: 255
    t.integer "redirect_tag_id"
    t.datetime "updated_at", default: "2014-01-26 03:27:52"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "trashes", id: :serial, force: :cascade do |t|
    t.string "key", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_trashes_on_key", unique: true
  end

  create_table "upcomings", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.datetime "date"
    t.string "description", limit: 255
    t.string "url", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "wikipedia"
    t.string "name"
    t.index ["date"], name: "index_upcomings_on_date"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 255, null: false
    t.integer "comment_karma", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "link_karma", default: 0
    t.index ["username"], name: "index_users_on_username"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
