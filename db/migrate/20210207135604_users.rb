class Users < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false #メールアドレス
      t.string :password, null: false #パスワード
      t.string :name, null:false #slack名
      t.integer :gender, null:false #性別
      t.string :age #世代
      t.integer :employment_form, null:false,:default => #就業形態
      t.string :prefecture #住んでる都道府県
      t.string :available_work_time #稼働可能時間帯
      t.string :qualification #資格取得
      t.string :hobby #趣味
      t.string :special_skill #得意なこと
      t.string :want_talk #話したいこと
      t.string :not_want_talk #話したこと
      t.text :free_area #話したくないこと
      t.integer :zasetsu_count, null: false,:default => #フリーエリア
      t.string :facebook_url #挫折カウント
      t.string :twitter_url #Facebook URL
      t.string :Insta_url #Instagram URL
      t.string :github_url #GitHub URL
      t.string :port_url #ポートフォリオURL URL
      t.datetime :deleted_at, null: false,:default => #削除日時
      t.timestamps :created_at,null: false #作成日時
      t.timestamps :updated_at,null: false #更新日時
    end
  end
end