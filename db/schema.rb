# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140209144243) do

  create_table "administrators", force: true do |t|
    t.string   "username",          null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contractable_id"
    t.string   "contractable_type"
  end

  add_index "administrators", ["contractable_id", "contractable_type"], name: "index_administrators_on_contractable_id_and_contractable_type", using: :btree

  create_table "agencies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agencies_salons", force: true do |t|
    t.integer "agency_id"
    t.integer "salon_id"
  end

  add_index "agencies_salons", ["agency_id"], name: "index_agencies_salons_on_agency_id", using: :btree
  add_index "agencies_salons", ["salon_id"], name: "index_agencies_salons_on_salon_id", using: :btree

  create_table "cart_items", force: true do |t|
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cart_id"
    t.integer  "product_id"
  end

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "consumer_id"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_items", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_items", ["category_id"], name: "index_category_items_on_category_id", using: :btree

  create_table "consumers", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consumers", ["email"], name: "index_consumers_on_email", unique: true, using: :btree
  add_index "consumers", ["reset_password_token"], name: "index_consumers_on_reset_password_token", unique: true, using: :btree

  create_table "file_storages", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "origin_price"
    t.integer  "backmargin_salon"
    t.integer  "backmargin_agency"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "consumer_id"
    t.string   "salon_name"
    t.integer  "salon_id"
    t.integer  "payment_id"
    t.string   "payment_type"
  end

  add_index "orders", ["consumer_id"], name: "index_orders_on_consumer_id", using: :btree
  add_index "orders", ["payment_id"], name: "index_orders_on_payment_id", using: :btree
  add_index "orders", ["salon_id"], name: "index_orders_on_salon_id", using: :btree

  create_table "pages", force: true do |t|
    t.text     "body"
    t.text     "style"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "render_type"
  end

  create_table "payment_creditcards", force: true do |t|
    t.string   "webpay_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_photos", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
  end

  add_index "product_photos", ["product_id"], name: "index_product_photos_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "sample",            default: false
    t.integer  "stock"
    t.integer  "series_id"
    t.integer  "category_id"
    t.integer  "price"
    t.integer  "page_id"
    t.integer  "backmargin_salon"
    t.integer  "backmargin_agency"
    t.string   "refnum"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["page_id"], name: "index_products_on_page_id", using: :btree
  add_index "products", ["series_id"], name: "index_products_on_series_id", using: :btree

  create_table "salons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number"
    t.string   "owner"
    t.string   "office"
    t.string   "person_in_charge"
    t.string   "grade"
    t.text     "address"
    t.string   "tel"
    t.string   "website"
  end

  create_table "series", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "topimage_file_name"
    t.string   "topimage_content_type"
    t.integer  "topimage_file_size"
    t.datetime "topimage_updated_at"
  end

  create_table "series_items", force: true do |t|
    t.string   "name"
    t.integer  "series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "series_items", ["series_id"], name: "index_series_items_on_series_id", using: :btree

  create_table "settings", force: true do |t|
    t.integer  "tax_percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipments", force: true do |t|
    t.string   "name"
    t.string   "postalcode"
    t.string   "prefecture"
    t.string   "address"
    t.string   "building"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  add_index "shipments", ["order_id"], name: "index_shipments_on_order_id", using: :btree

  create_table "solution_items", force: true do |t|
    t.string   "name"
    t.integer  "solution_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solution_items", ["solution_id"], name: "index_solution_items_on_solution_id", using: :btree

  create_table "solutions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
