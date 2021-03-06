class AddSkillCategoryIdToSkillSets < ActiveRecord::Migration[5.2]
  def change
    add_reference :skill_sets, :skill_category, foreign_key: true
  end
end
