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


ActiveRecord::Schema.define(version: 2022_06_09_105804) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "choice_points", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "deadline"
    t.boolean "successful"
    t.text "feedback"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_choice_points_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.boolean "chosen"
    t.text "description"
    t.float "score"
    t.text "pros"
    t.text "cons"
    t.bigint "choice_point_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["choice_point_id"], name: "index_options_on_choice_point_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "choice_point_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["choice_point_id"], name: "index_tags_on_choice_point_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "reputation", default: 1
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "option_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_id"], name: "index_votes_on_option_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "choice_points", "users"
  add_foreign_key "options", "choice_points"
  add_foreign_key "tags", "choice_points"
  add_foreign_key "votes", "options"
  add_foreign_key "votes", "users"
end
