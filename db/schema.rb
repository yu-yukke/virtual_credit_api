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

ActiveRecord::Schema.define(version: 0) do

  create_table "admin_users", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.string "email", limit: 191, null: false
    t.string "password_digest", limit: 191, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_admin_users_on_deleted_at"
    t.index ["email", "deleted_at"], name: "index_admin_users_on_email_deleted_uniq", unique: true
    t.index ["email"], name: "index_admin_users_on_email"
    t.index ["password_digest"], name: "index_admin_users_on_password_digest", unique: true
  end

  create_table "asset_mappings", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.bigint "work_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["asset_id"], name: "index_asset_mappings_on_asset_id"
    t.index ["deleted_at"], name: "index_asset_mappings_on_deleted_at"
    t.index ["work_id"], name: "index_asset_mappings_on_work_id"
  end

  create_table "assets", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", limit: 191, null: false
    t.string "url", null: false
    t.string "image_url", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_assets_on_deleted_at"
    t.index ["user_id"], name: "index_assets_on_user_id"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.string "ancestry", limit: 191
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_categories_on_deleted_at"
  end

  create_table "creator_mappings", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "work_id", null: false
    t.boolean "is_author", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_creator_mappings_on_deleted_at"
    t.index ["user_id"], name: "index_creator_mappings_on_user_id"
    t.index ["work_id"], name: "index_creator_mappings_on_work_id"
  end

  create_table "favorites", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "work_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_favorites_on_deleted_at"
    t.index ["user_id"], name: "index_favorites_on_user_id"
    t.index ["work_id"], name: "index_favorites_on_work_id"
  end

  create_table "image_files", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.integer "sequence", null: false
    t.integer "file_type", default: 0, null: false
    t.string "image_url"
    t.string "video_url"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_image_files_on_deleted_at"
    t.index ["work_id"], name: "index_image_files_on_work_id"
  end

  create_table "inquiries", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "inquiry_type", default: 0, null: false
    t.text "text", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_inquiries_on_deleted_at"
    t.index ["user_id"], name: "index_inquiries_on_user_id"
  end

  create_table "job_mappings", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_job_mappings_on_deleted_at"
    t.index ["job_id"], name: "index_job_mappings_on_job_id"
    t.index ["user_id"], name: "index_job_mappings_on_user_id"
  end

  create_table "jobs", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.string "ancestry", limit: 191
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_jobs_on_deleted_at"
  end

  create_table "link_in_bios", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "name", limit: 191, null: false
    t.string "url", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_link_in_bios_on_deleted_at"
    t.index ["work_id"], name: "index_link_in_bios_on_work_id"
  end

  create_table "notification_details", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "notification_id", null: false
    t.string "subject", limit: 191, null: false
    t.text "description", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "notification_details_on_deleted_at"
    t.index ["notification_id"], name: "notification_details_on_notification_id"
  end

  create_table "notifications", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.datetime "start_at", null: false
    t.datetime "end_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_notifications_on_deleted_at"
  end

  create_table "release_notes", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "version", null: false
    t.string "subject", limit: 191, null: false
    t.text "description", null: false
    t.datetime "released_at", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_release_notes_on_deleted_at"
  end

  create_table "role_mappings", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "creator_mapping_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["creator_mapping_id"], name: "index_role_maps_on_creator_mapping_id"
    t.index ["deleted_at"], name: "index_role_maps_on_deleted_at"
    t.index ["role_id"], name: "index_role_maps_on_role_id"
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_roles_on_deleted_at"
  end

  create_table "socials", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "twitter_id", limit: 191
    t.string "youtube_url", limit: 191
    t.string "instagram_url", limit: 191
    t.string "facebook_url", limit: 191
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_socials_on_deleted_at"
    t.index ["user_id"], name: "index_socials_on_user_id", unique: true
  end

  create_table "tag_mappings", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_tag_mappings_on_deleted_at"
    t.index ["tag_id"], name: "index_tag_mappings_on_tag_id"
    t.index ["work_id"], name: "index_tag_mappings_on_work_id"
  end

  create_table "tags", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", limit: 191, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_tags_on_deleted_at"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "user_authentications", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider", limit: 191, default: "email", null: false
    t.string "uid", limit: 191, default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.text "tokens"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_user_auths_on_deleted_at"
    t.index ["provider", "uid"], name: "index_user_auths_on_provider_uid_unique", unique: true
    t.index ["user_id"], name: "index_user_auths_on_user_id", unique: true
  end

  create_table "user_logins", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "email", limit: 191, null: false
    t.string "password_digest", limit: 191, null: false
    t.datetime "last_logged_in_at", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_user_logins_on_deleted_at"
    t.index ["email", "deleted_at"], name: "index_user_logins_on_email_deleted_uniq", unique: true
    t.index ["email"], name: "index_user_logins_on_email"
    t.index ["password_digest"], name: "index_user_logins_on_password_digest", unique: true
    t.index ["user_id"], name: "index_user_logins_on_user_id", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.string "description", limit: 191
    t.string "main_image_url"
    t.string "thumb_image_url"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
  end

  create_table "works", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name", limit: 191, null: false
    t.text "description", null: false
    t.string "main_image_url", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "index_works_on_category_id"
    t.index ["deleted_at"], name: "index_works_on_deleted_at"
  end

end
