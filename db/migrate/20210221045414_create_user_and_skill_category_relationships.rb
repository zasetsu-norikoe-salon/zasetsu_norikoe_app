class CreateUserAndSkillCategoryRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :user_and_skill_category_relationships, comment: 'ユーザー・スキル属性紐付けデータ' do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.references :skill_category, null: false, foreign_key: true, comment: 'スキル属性ID'
      t.datetime   :deleted_at, comment: '削除日時'

      t.timestamps
    end
  end
end
