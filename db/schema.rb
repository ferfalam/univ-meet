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

ActiveRecord::Schema.define(version: 2021_10_18_171314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "context"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.bigint "student_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["student_id"], name: "index_comments_on_student_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.string "statut", null: false
    t.integer "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id"
    t.index ["student_id"], name: "index_conversations_on_student_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.bigint "student_id"
    t.index ["post_id"], name: "index_favorites_on_post_id"
    t.index ["student_id"], name: "index_favorites_on_student_id"
  end

  create_table "fields", force: :cascade do |t|
    t.string "name", null: false
    t.string "acronym", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "university_id"
    t.index ["university_id"], name: "index_fields_on_university_id"
  end

  create_table "group_students_maps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id"
    t.bigint "group_id"
    t.index ["group_id"], name: "index_group_students_maps_on_group_id"
    t.index ["student_id"], name: "index_group_students_maps_on_student_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id"
    t.bigint "conversation_id"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["student_id"], name: "index_messages_on_student_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id"
    t.index ["student_id"], name: "index_posts_on_student_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "approve", default: false
    t.boolean "rejet", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "university_id"
    t.bigint "student_id"
    t.index ["student_id"], name: "index_requests_on_student_id"
    t.index ["university_id"], name: "index_requests_on_university_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "lastname", null: false
    t.string "firstname", null: false
    t.string "phone_number", null: false
    t.string "personal_number", null: false
    t.string "card_image", null: false
    t.boolean "valid_account", default: false, null: false
    t.datetime "valid_until", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "field_id"
    t.bigint "university_id"
    t.index ["field_id"], name: "index_students_on_field_id"
    t.index ["university_id"], name: "index_students_on_university_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.string "phone_number"
    t.boolean "admin", default: false, null: false
    t.boolean "valid_account", default: false, null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "students"
  add_foreign_key "conversations", "students"
  add_foreign_key "favorites", "posts"
  add_foreign_key "favorites", "students"
  add_foreign_key "fields", "universities"
  add_foreign_key "group_students_maps", "groups"
  add_foreign_key "group_students_maps", "students"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "students"
  add_foreign_key "posts", "students"
  add_foreign_key "requests", "students"
  add_foreign_key "requests", "universities"
  add_foreign_key "students", "fields"
  add_foreign_key "students", "universities"
end
