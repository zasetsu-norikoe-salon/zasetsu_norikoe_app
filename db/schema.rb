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

ActiveRecord::Schema.define(version: 2021_02_07_135604) do

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "ユーザーデータ", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "password", null: false, comment: "パスワード"
    t.string "name", null: false, comment: "slack名"
    t.integer "gender", default: 1, null: false, comment: "性別"
    t.string "age", comment: "世代"
    t.integer "employment_form", default: 1, null: false, comment: "就業形態"
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
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
