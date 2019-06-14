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

ActiveRecord::Schema.define(version: 2019_06_14_023038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amazon_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buyers", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id"
    t.string "photo"
    t.boolean "shopify_active", default: false
    t.index ["owner_id"], name: "index_companies_on_owner_id"
  end

  create_table "company_groups", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_groups_on_company_id"
    t.index ["group_id"], name: "index_company_groups_on_group_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "group_type", default: "team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kpis", force: :cascade do |t|
    t.text "data_type"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "query"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "item_price_cents"
    t.integer "quantity"
    t.integer "shipping_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.bigint "product_id"
    t.string "external_order_item_id"
    t.string "currency"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "purchase_date"
    t.integer "order_total_cents"
    t.string "external_source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "buyer_id"
    t.string "order_status"
    t.string "shipping_address_region"
    t.string "shipping_address_country_code"
    t.string "currency"
    t.integer "items_total"
    t.string "external_order_id"
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "sku"
    t.string "product_type"
    t.string "product_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "report_accesses", force: :cascade do |t|
    t.integer "report_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.index ["group_id"], name: "index_report_accesses_on_group_id"
    t.index ["report_id", "user_id"], name: "index_report_accesses_on_report_id_and_user_id", unique: true
  end

  create_table "reports", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id"
    t.index ["owner_id"], name: "index_reports_on_owner_id"
  end

  create_table "user_platforms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "platform_id"
    t.index ["platform_id"], name: "index_user_platforms_on_platform_id"
    t.index ["user_id"], name: "index_user_platforms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "first_name"
    t.string "last_name"
    t.string "team"
    t.boolean "admin", default: false, null: false
    t.string "photo"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "widgets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "grid_item_position"
    t.string "display_type"
    t.bigint "kpi_id"
    t.index ["kpi_id"], name: "index_widgets_on_kpi_id"
    t.index ["report_id"], name: "index_widgets_on_report_id"
  end

  create_table "woocommerce_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "companies", "users", column: "owner_id"
  add_foreign_key "company_groups", "companies"
  add_foreign_key "company_groups", "groups"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "buyers"
  add_foreign_key "report_accesses", "groups"
  add_foreign_key "reports", "users", column: "owner_id"
  add_foreign_key "user_platforms", "platforms"
  add_foreign_key "user_platforms", "users"
  add_foreign_key "users", "companies"
  add_foreign_key "widgets", "kpis"
  add_foreign_key "widgets", "reports"
end
