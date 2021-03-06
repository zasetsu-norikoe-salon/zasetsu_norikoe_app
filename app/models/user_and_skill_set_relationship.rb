# frozen_string_literal: true

class UserAndSkillSetRelationship < ApplicationRecord
  acts_as_paranoid
  extend Enumerize

  # Association
  belongs_to :user
  belongs_to :skill_set

  # 経験値(勉強中: 1, 実務経験あり: 2, ベテラン: 3)
  enumerize :level,
            in: { junior: 1, middle: 2, veteran: 3 },
            default: :junior

  validates :level, presence: true
end
