# frozen_string_literal: true

class UserAndSkillCategoryRelationship < ApplicationRecord
  acts_as_paranoid

  # Association
  belongs_to :user
  belongs_to :skill_category
end
