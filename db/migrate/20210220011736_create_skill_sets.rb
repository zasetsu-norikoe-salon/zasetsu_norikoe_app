class CreateSkillSets < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_sets, comment: 'スキルセットデータ(使用言語, FW等)' do |t|
      t.string    :name, null: false, comment: 'スキルセット名'
      t.datetime  :deleted_at, comment: '削除日時'

      t.timestamps
    end
  end
end
