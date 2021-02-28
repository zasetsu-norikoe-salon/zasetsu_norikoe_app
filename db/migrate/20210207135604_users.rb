class Users < ActiveRecord::Migration[5.2]
  def change
    create_table :users, comment: 'ユーザーデータ' do |t|
      t.string :email, null: false, comment: 'メールアドレス'
      t.string :encrypted_password, null: false, default: '', comment: 'パスワード'
      t.string :name, null: false, comment: 'slack名'
      t.integer :gender, null: false, default: 1, comment: '性別'
      t.string :age, comment: '世代'
      t.integer :employment_form, null: false, default: 1, comment: '就業形態'
      t.string :prefecture, comment: '住んでる都道府県'
      t.string :available_work_time, comment: '稼働可能時間帯'
      t.string :qualification, comment: '資格取得'
      t.string :hobby, comment: '趣味'
      t.string :special_skill, comment: '得意なこと'
      t.string :want_talk, comment: '話したいこと'
      t.string :not_want_talk, comment: '話したくないこと'
      t.text :free_area, comment: 'フリーエリア'
      t.integer :zasetsu_count, null: false, default: 0, comment: '挫折カウント'
      t.string :facebook_url, comment: 'Facebook URL'
      t.string :insta_url, comment: 'Instagram URL'
      t.string :twitter_url, comment: 'Twitter URL'
      t.string :github_url, comment: 'GitHub URL'
      t.string :port_url, comment: 'ポートフォリオURL'
      t.datetime :deleted_at, comment: '削除日時'

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps
    end
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
