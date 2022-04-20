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

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.string "description", limit: 191
    t.string "main_image", limit: 191
    t.string "thumb_image", limit: 191
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
  end

end
