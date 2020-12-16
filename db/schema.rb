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

ActiveRecord::Schema.define(version: 2020_12_16_135125) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "ad_user_detail_headers", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ad_user_details", force: :cascade do |t|
    t.integer "office_id"
    t.string "position"
    t.integer "ad_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "phonenumber"
    t.text "phonenumber_2"
    t.text "storage", default: "{}"
    t.index ["ad_user_id"], name: "index_ad_user_details_on_ad_user_id"
  end

  create_table "ad_user_headers", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ad_users", force: :cascade do |t|
    t.string "dn"
    t.string "objectclass"
    t.string "cn"
    t.string "sn"
    t.string "givenname"
    t.text "description"
    t.string "distinguishedname"
    t.string "instancetype"
    t.datetime "whencreated"
    t.datetime "whenchanged"
    t.string "displayname"
    t.string "usncreated"
    t.string "memberof"
    t.string "usnchanged"
    t.string "name"
    t.string "objectguid"
    t.string "useraccountcontrol"
    t.string "badpwdcount"
    t.string "codepage"
    t.string "countrycode"
    t.datetime "badpasswordtime"
    t.datetime "lastlogoff"
    t.datetime "lastlogon"
    t.string "logonhours"
    t.datetime "pwdlastset"
    t.string "primarygroupid"
    t.string "objectsid"
    t.string "admincount"
    t.datetime "accountexpires"
    t.string "logoncount"
    t.string "samaccountname"
    t.string "samaccounttype"
    t.datetime "lockouttime"
    t.string "objectcategory"
    t.string "iscriticalsystemobject"
    t.string "dscorepropagationdata"
    t.datetime "lastlogontimestamp"
    t.string "msds-supportedencryptiontypes"
    t.string "mail"
    t.string "userprincipalname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["objectguid"], name: "index_ad_users_on_objectguid", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "manager_id"
    t.index ["manager_id"], name: "index_employees_on_manager_id"
  end

  create_table "holiday_requests", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "NEW"
    t.date "since"
    t.date "until"
    t.integer "employee_id"
    t.integer "inbox_id"
    t.index ["inbox_id"], name: "index_holiday_requests_on_inbox_id"
  end

  create_table "holidays", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "inboxes", force: :cascade do |t|
    t.integer "employee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_inboxes_on_employee_id"
  end

  create_table "itemtags", force: :cascade do |t|
    t.string "name"
    t.string "default_value_mask"
    t.boolean "store_value", default: false
    t.text "description"
    t.string "display_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_itemtags_on_name", unique: true
  end

  create_table "office_headers", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "offices", force: :cascade do |t|
    t.string "name"
    t.string "name_2"
    t.string "postalcode"
    t.string "phonenumber"
    t.string "phonenumber_2"
    t.string "opt_info"
    t.string "opt_info_2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "fax"
    t.string "fax_2"
    t.string "location"
    t.string "location_2"
  end

  create_table "sent_items", force: :cascade do |t|
    t.string "title"
    t.string "item_type"
    t.boolean "status"
    t.text "content"
    t.text "status_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "signatures", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_signatures_on_user_id"
  end

  create_table "smtp_settings", force: :cascade do |t|
    t.string "address"
    t.integer "port"
    t.string "domain"
    t.string "user_name"
    t.string "password"
    t.string "authentication"
    t.boolean "tls"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "store_password"
    t.string "sender"
  end

  create_table "tag_custom_masks", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "template_tagging_id"
    t.boolean "use", default: false
  end

  create_table "template_taggings", force: :cascade do |t|
    t.integer "template_id", null: false
    t.integer "itemtag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["itemtag_id"], name: "index_template_taggings_on_itemtag_id"
    t.index ["template_id"], name: "index_template_taggings_on_template_id"
  end

  create_table "template_tags", force: :cascade do |t|
    t.string "name"
    t.string "default_value_mask"
    t.boolean "store_value", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.string "display_name"
    t.string "category"
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.index ["name"], name: "index_templates_on_name", unique: true
  end

  create_table "user_holders", force: :cascade do |t|
    t.integer "user_id"
    t.text "objectguid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "session_id"
    t.text "google_client"
    t.string "email"
    t.string "picture_google"
    t.string "picture_local"
    t.boolean "anonymous", default: true
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ad_user_details", "offices"
  add_foreign_key "holiday_requests", "employees"
  add_foreign_key "signatures", "users"
  add_foreign_key "tag_custom_masks", "template_taggings"
  add_foreign_key "template_taggings", "itemtags"
  add_foreign_key "template_taggings", "templates"
end
