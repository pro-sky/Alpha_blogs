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

ActiveRecord::Schema.define(version: 20240805052557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_categories", force: :cascade do |t|
    t.integer "article_id"
    t.integer "category_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "discription"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.datetime "deleted_at"
    t.integer "view_count", default: 0
    t.integer "like_count", default: 0
    t.index ["deleted_at"], name: "index_articles_on_deleted_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "like_count", default: 0
    t.datetime "deleted_at"
    t.index ["article_id"], name: "index_comments_on_article_id"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "direct_messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reactions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "reactionable_type"
    t.bigint "reactionable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "article_id"
    t.integer "comment_id"
    t.index ["reactionable_type", "reactionable_id"], name: "index_reactions_on_reactionable_type_and_reactionable_id"
    t.index ["user_id"], name: "index_reactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "reset_token"
    t.datetime "reset_sent_at"
  end

  add_foreign_key "comments", "articles"
  add_foreign_key "comments", "users"
  add_foreign_key "reactions", "users"
end
