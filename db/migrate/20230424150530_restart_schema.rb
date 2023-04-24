class RestartSchema < ActiveRecord::Migration[7.0]
  def change
    create_table "follows", force: :cascade do |t|
      t.integer "follower_id", null: false
      t.integer "followee_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["followee_id"], name: "index_follows_on_followee_id"
      t.index ["follower_id"], name: "index_follows_on_follower_id"
    end

    create_table "sleeps", force: :cascade do |t|
      t.integer "user_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_sleeps_on_user_id"
    end

    create_table "users", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    add_foreign_key "follows", "users", column: "followee_id"
    add_foreign_key "follows", "users", column: "follower_id"
    add_foreign_key "sleeps", "users"
  end
end
