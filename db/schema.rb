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

ActiveRecord::Schema.define(version: 2021_02_21_045425) do

  create_table "skill_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "スキル属性データ(Web制作等)", force: :cascade do |t|
    t.string "name", null: false, comment: "スキル属性名"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_sets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "スキルセットデータ(使用言語, FW等)", force: :cascade do |t|
    t.string "name", null: false, comment: "スキルセット名"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_and_skill_category_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "ユーザー・スキル属性紐付けデータ", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "ユーザーID"
    t.bigint "skill_category_id", null: false, comment: "スキル属性ID"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_category_id"], name: "index_user_and_skill_category_relationships_on_skill_category_id"
    t.index ["user_id"], name: "index_user_and_skill_category_relationships_on_user_id"
  end

  create_table "user_and_skill_set_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "ユーザー・スキルセット紐付けデータ", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "ユーザーID"
    t.bigint "skill_set_id", null: false, comment: "スキルセットID"
    t.integer "level", default: 3, null: false, comment: "経験値(1: ベテラン 2:実務経験あり 3:勉強中)"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_set_id"], name: "index_user_and_skill_set_relationships_on_skill_set_id"
    t.index ["user_id"], name: "index_user_and_skill_set_relationships_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "ユーザーデータ", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "encrypted_password", default: "", null: false, comment: "パスワード"
    t.string "name", null: false, comment: "slack名"
    t.integer "gender", default: 0, null: false, comment: "性別(0: 未回答 1:男性 2:女性 9:その他)"
    t.string "age", comment: "世代"
    t.integer "employment_type", default: 1, null: false, comment: "就業形態(1: 正社員, 2: 正社員(異業種), 3: 副業, 4: フリーランス, 5: インターン, 6: 求職中)"
    t.string "prefecture", comment: "住んでる都道府県"
    t.string "available_work_time", comment: "稼働可能時間帯"
    t.string "qualification", comment: "資格取得"
    t.string "hobby", comment: "趣味"
    t.string "special_skill", comment: "得意なこと"
    t.string "want_talk", comment: "話したいこと"
    t.string "not_want_talk", comment: "話したくないこと"
    t.text "free_area", comment: "フリーエリア"
    t.integer "zasetsu_count", default: 0, null: false, comment: "挫折カウント"
    t.string "facebook_url", comment: "Facebook URL"
    t.string "insta_url", comment: "Instagram URL"
    t.string "twitter_url", comment: "Twitter URL"
    t.string "github_url", comment: "GitHub URL"
    t.string "port_url", comment: "ポートフォリオURL"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "user_and_skill_category_relationships", "skill_categories"
  add_foreign_key "user_and_skill_category_relationships", "users"
  add_foreign_key "user_and_skill_set_relationships", "skill_sets"
  add_foreign_key "user_and_skill_set_relationships", "users"
end
