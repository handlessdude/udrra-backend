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

ActiveRecord::Schema.define(version: 2021_12_13_204812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "details", force: :cascade do |t|
    t.string "type", null: false
    t.string "entity_name", null: false
    t.string "entity_duration", null: false
    t.bigint "entity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entity_id"], name: "index_details_on_entity_id"
  end

  create_table "details_tracks", force: :cascade do |t|
    t.bigint "detail_id", null: false
    t.bigint "track_id", null: false
    t.boolean "finished", default: false
    t.boolean "assigned", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["detail_id"], name: "index_details_tracks_on_detail_id"
    t.index ["track_id"], name: "index_details_tracks_on_track_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "faculties", force: :cascade do |t|
    t.string "faculty", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications_users", force: :cascade do |t|
    t.bigint "notification_id", null: false
    t.bigint "user_id", null: false
    t.boolean "looked", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_id"], name: "index_notifications_users_on_notification_id"
    t.index ["user_id"], name: "index_notifications_users_on_user_id"
  end

  create_table "posted_files", force: :cascade do |t|
    t.string "type", null: false
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "test_answer_results", force: :cascade do |t|
    t.bigint "test_question_id", null: false
    t.bigint "test_answer_id", null: false
    t.bigint "test_id", null: false
    t.boolean "is_correct", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_answer_id"], name: "index_test_answer_results_on_test_answer_id"
    t.index ["test_id"], name: "index_test_answer_results_on_test_id"
    t.index ["test_question_id"], name: "index_test_answer_results_on_test_question_id"
  end

  create_table "test_answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "test_question_id", null: false
    t.bigint "test_question_variant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_question_id"], name: "index_test_answers_on_test_question_id"
    t.index ["test_question_variant_id"], name: "index_test_answers_on_test_question_variant_id"
    t.index ["user_id"], name: "index_test_answers_on_user_id"
  end

  create_table "test_correct_answers", force: :cascade do |t|
    t.bigint "test_question_id", null: false
    t.bigint "test_question_variant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_question_id"], name: "index_test_correct_answers_on_test_question_id"
    t.index ["test_question_variant_id"], name: "index_test_correct_answers_on_test_question_variant_id"
  end

  create_table "test_question_variants", force: :cascade do |t|
    t.bigint "test_question_id", null: false
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_question_id"], name: "index_test_question_variants_on_test_question_id"
  end

  create_table "test_questions", force: :cascade do |t|
    t.bigint "test_id", null: false
    t.string "type", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.string "img", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_id"], name: "index_test_questions_on_test_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.text "instruction", null: false
    t.string "duration", null: false
    t.string "img", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "track_name", null: false
    t.text "preview_text", null: false
    t.string "preview_picture", null: false
    t.boolean "published", null: false
    t.string "mode", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tracks_users", force: :cascade do |t|
    t.bigint "track_id", null: false
    t.bigint "user_id", null: false
    t.string "status", null: false
    t.boolean "finished", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["track_id"], name: "index_tracks_users_on_track_id"
    t.index ["user_id"], name: "index_tracks_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.string "encrypted_password", null: false
    t.string "first_name", null: false
    t.string "second_name", null: false
    t.string "avatar_url"
    t.bigint "faculty_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_users_on_faculty_id"
  end

end
