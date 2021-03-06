# frozen_string_literal: true

class SkillSet < ApplicationRecord
  acts_as_paranoid

  # Association
  has_many :user_and_skill_set_relationships, dependent: :destroy
  has_many :users, through: :user_and_skill_set_relationships

  validates :name, presence: true
end
