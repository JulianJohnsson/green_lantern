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

ActiveRecord::Schema.define(version: 2019_12_06_233128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bankin_categories", force: :cascade do |t|
    t.integer "bankin_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bridges", force: :cascade do |t|
    t.string "token"
    t.boolean "bank_connected"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.datetime "expires_at"
    t.datetime "last_sync_at"
    t.string "credential"
    t.index ["user_id"], name: "index_bridges_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "external_id"
    t.decimal "coeff"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.string "emoji"
    t.boolean "visible"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "transaction_id"
    t.string "description"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.decimal "total"
    t.text "detail", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "house_size"
    t.decimal "furniture"
    t.decimal "clothes"
    t.decimal "other_goods"
    t.decimal "healthcare"
    t.decimal "subscriptions"
    t.decimal "other_services"
  end

  create_table "gifts", force: :cascade do |t|
    t.string "author_email"
    t.string "recipient_email"
    t.integer "quantity"
    t.decimal "price"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "country_id"
    t.string "author_name"
    t.string "recipient_name"
    t.text "invitation_text"
    t.string "formula"
    t.string "charge_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.text "data", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "opponent_id"
    t.string "badge"
  end

  create_table "preferences", force: :cascade do |t|
    t.integer "user_id"
    t.string "city"
    t.integer "regime"
    t.integer "energy_contract"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "country"
    t.integer "kind"
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.string "image"
    t.text "why"
  end

  create_table "reductions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.integer "parent_category_id"
    t.string "title"
    t.decimal "month_carbone"
    t.decimal "month_cost"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer "country_id"
    t.decimal "total"
    t.text "detail", default: [], array: true
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "main_transport_mode"
    t.integer "long_flights"
    t.integer "short_flights"
    t.integer "house_size"
    t.integer "regime"
    t.integer "kind"
    t.decimal "recent_total"
    t.text "recent_detail", default: [], array: true
    t.text "top_category", default: [], array: true
    t.text "top_transaction", default: [], array: true
    t.text "top_growth", default: [], array: true
    t.integer "week_basic_car"
    t.integer "week_electric_car"
    t.integer "week_moto"
    t.integer "week_public_trans"
    t.integer "energy"
    t.integer "enr"
    t.integer "redmeat"
    t.integer "poultry"
    t.integer "dairy"
    t.decimal "goods_furnitures"
    t.decimal "goods_clothes"
    t.decimal "goods_others"
    t.decimal "services_health"
    t.decimal "services_plans"
    t.decimal "services_others"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "plan"
    t.decimal "price"
    t.string "frequency"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "external_id"
    t.string "description"
    t.string "raw_description"
    t.decimal "amount"
    t.date "date"
    t.integer "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "carbone"
    t.integer "parent_category_id"
    t.boolean "updated_by_user"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "provider"
    t.string "uid"
    t.string "city"
    t.date "birthdate"
    t.string "stripe_id"
    t.string "stripe_subscription_id"
    t.integer "card_last4"
    t.integer "card_exp_month"
    t.integer "card_exp_year"
    t.string "card_type"
    t.boolean "subscribed"
    t.boolean "onboarded"
    t.string "subscription_plan"
    t.decimal "subscription_price"
    t.date "subscription_started_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bridges", "users"
  add_foreign_key "transactions", "users"
end
