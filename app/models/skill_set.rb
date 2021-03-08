# frozen_string_literal: true

class SkillSet < ApplicationRecord
  acts_as_paranoid

  # Association
  has_many :user_and_skill_set_relationships, dependent: :destroy
  has_many :users, through: :user_and_skill_set_relationships
  belongs_to :skill_category

  validates :name, presence: true

  def level(user_id)
    user_and_skill_set_relationships.find_by(user_id: user_id).level_text
  end
end
