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

ActiveRecord::Schema[8.0].define(version: 2025_08_08_103610) do
  create_table "prices", force: :cascade do |t|
    t.string "base", null: false
    t.string "quote", null: false
    t.float "value", null: false
    t.datetime "delete_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base", "quote"], name: "index_prices_on_base_and_quote"
    t.index ["delete_at"], name: "index_prices_on_delete_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "user_id"
    t.string "type"
    t.string "symbol"
    t.decimal "amount"
    t.string "gateway_id"
    t.string "gateway"
    t.integer "confirmations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_transactions_on_created_at"
    t.index ["gateway_id"], name: "index_transactions_on_gateway_id"
    t.index ["user_id", "symbol"], name: "index_transactions_on_user_id_and_symbol"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "email_verification_token"
    t.datetime "email_verified_at"
    t.integer "referrer_id"
    t.string "referral_code"
    t.string "locale", default: "en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["email_verification_token"], name: "index_users_on_email_verification_token", unique: true
    t.index ["referral_code"], name: "index_users_on_referral_code", unique: true
    t.index ["referrer_id"], name: "index_users_on_referrer_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "type"
    t.integer "index", default: 0
    t.string "user_id"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_wallets_on_address"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "users", "users", column: "referrer_id"
end
