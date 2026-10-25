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

ActiveRecord::Schema[8.1].define(version: 2026_10_21_062634) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "batches", force: :cascade do |t|
    t.integer "game_id"
    t.string "codename"
    t.string "file"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source_locale"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translation_keys", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "state"
    t.integer "game_id"
    t.boolean "translated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "batch_id"
  end

  create_table "translations", force: :cascade do |t|
    t.integer "translation_key_id"
    t.string "locale"
    t.text "value"
    t.string "state"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "batch_id"
    t.index ["locale", "state"], name: "index_translations_on_locale_and_state"
    t.index ["locale"], name: "index_translations_on_locale"
    t.index ["state"], name: "index_translations_on_state"
    t.index ["translation_key_id", "locale"], name: "index_translations_on_translation_key_id_and_locale", unique: true
  end
end
