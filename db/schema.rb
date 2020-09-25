# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_19_190020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "set"
    t.string "category"
    t.string "rarity"
    t.json "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["set", "category", "rarity"], name: "index_cards_on_set_and_category_and_rarity"
  end

  create_table "cards_decks", id: false, force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.bigint "card_id", null: false
    t.index ["deck_id", "card_id"], name: "index_cards_decks_on_deck_id_and_card_id"
  end

  create_table "cards_packs", id: false, force: :cascade do |t|
    t.bigint "pack_id", null: false
    t.bigint "card_id", null: false
    t.index ["pack_id", "card_id"], name: "index_cards_packs_on_pack_id_and_card_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.string "user"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user"], name: "index_decks_on_user"
  end

  create_table "drafters", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "user"
    t.bigint "draft_id"
    t.integer "pack_number", default: 0
    t.json "expected_pack"
    t.string "state"
    t.bigint "deck_id"
    t.bigint "left_id"
    t.bigint "right_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_id"], name: "index_drafters_on_deck_id"
    t.index ["draft_id"], name: "index_drafters_on_draft_id"
    t.index ["left_id"], name: "index_drafters_on_left_id"
    t.index ["right_id"], name: "index_drafters_on_right_id"
    t.index ["user"], name: "index_drafters_on_user"
  end

  create_table "drafts", force: :cascade do |t|
    t.string "owner"
    t.string "state"
    t.json "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "packs", force: :cascade do |t|
    t.bigint "drafter_id"
    t.string "pass_direction"
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["drafter_id"], name: "index_packs_on_drafter_id"
  end

  add_foreign_key "drafters", "drafters", column: "left_id"
  add_foreign_key "drafters", "drafters", column: "right_id"
end
