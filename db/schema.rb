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

ActiveRecord::Schema.define(version: 20170824125758) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_books", force: :cascade do |t|
    t.bigint "author_id"
    t.bigint "book_id"
    t.index ["author_id"], name: "index_authors_books_on_author_id"
    t.index ["book_id"], name: "index_authors_books_on_book_id"
  end

  create_table "billing_addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "phone"
    t.bigint "user_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.index ["country_id"], name: "index_billing_addresses_on_country_id"
    t.index ["order_id"], name: "index_billing_addresses_on_order_id"
    t.index ["user_id"], name: "index_billing_addresses_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 8, scale: 2
    t.text "description"
    t.date "public_y"
    t.integer "height", limit: 2
    t.integer "weight", limit: 2
    t.integer "depth", limit: 2
    t.string "material"
    t.integer "reviews_qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.bigint "order_id"
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["order_id"], name: "index_books_on_order_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.decimal "price", precision: 8, scale: 2
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "order_id"
    t.integer "quantity"
    t.decimal "price", precision: 8, scale: 2
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_order_items_on_book_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "order"
    t.string "status"
    t.bigint "user_id"
    t.decimal "total_price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "coupon_id"
    t.bigint "shipping_methods_id"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["shipping_methods_id"], name: "index_orders_on_shipping_methods_id"
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "phone"
    t.bigint "user_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.index ["country_id"], name: "index_shipping_addresses_on_country_id"
    t.index ["order_id"], name: "index_shipping_addresses_on_order_id"
    t.index ["user_id"], name: "index_shipping_addresses_on_user_id"
  end

  create_table "shipping_methods", force: :cascade do |t|
    t.string "name"
    t.string "duration"
    t.decimal "price", precision: 8, scale: 2
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.text "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "authors_books", "authors"
  add_foreign_key "authors_books", "books"
  add_foreign_key "billing_addresses", "countries"
  add_foreign_key "billing_addresses", "orders"
  add_foreign_key "billing_addresses", "users"
  add_foreign_key "books", "categories"
  add_foreign_key "books", "orders"
  add_foreign_key "order_items", "books"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "coupons"
  add_foreign_key "orders", "shipping_methods", column: "shipping_methods_id"
  add_foreign_key "shipping_addresses", "countries"
  add_foreign_key "shipping_addresses", "orders"
  add_foreign_key "shipping_addresses", "users"
end
