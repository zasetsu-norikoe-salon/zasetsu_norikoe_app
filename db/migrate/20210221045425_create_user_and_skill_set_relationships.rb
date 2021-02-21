class CreateUserAndSkillSetRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :user_and_skill_set_relationships, comment: 'ユーザー・スキルセット紐付けデータ' do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.references :skill_set, null: false, foreign_key: true, comment: 'スキルセットID'
      t.integer    :level, null: false, default: 3, comment: '経験値(1: ベテラン 2:実務経験あり 3:勉強中)'
      t.datetime   :deleted_at, comment: '削除日時'

      t.timestamps
    end
  end
end
