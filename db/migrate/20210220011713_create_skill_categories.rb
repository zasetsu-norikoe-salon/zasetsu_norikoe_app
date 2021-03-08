class CreateSkillCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_categories, comment: 'スキル属性データ(Web制作等)' do |t|
      t.string    :name, null: false, comment: 'スキル属性名'
      t.datetime  :deleted_at, comment: '削除日時'

      t.timestamps
    end
  end
end
