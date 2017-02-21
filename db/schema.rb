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

ActiveRecord::Schema.define(version: 20170210022121) do

  create_table "bank_accounts", force: :cascade do |t|
    t.string   "serial"
    t.float    "blance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id", "product_id", "created_at"], name: "index_comments_on_user_id_and_product_id_and_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "discount_products", force: :cascade do |t|
    t.integer  "id_discount"
    t.integer  "id_product"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.string   "description"
    t.float    "value"
    t.datetime "date_start"
    t.datetime "date_end"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "unit_quantity"
    t.decimal  "unit_price"
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.float    "total_pay"
    t.integer  "status",     default: 0
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.boolean  "active"
    t.string   "description"
    t.string   "image"
    t.string   "classify"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "value"
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_ratings_on_product_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "address"
    t.boolean  "is_admin",        default: false
    t.string   "phone"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
  end

end
