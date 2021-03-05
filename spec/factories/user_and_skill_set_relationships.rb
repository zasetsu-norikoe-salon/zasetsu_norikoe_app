# frozen_string_literal: true

FactoryBot.define do
  factory :user_and_skill_set_relationship do
    association(:user)
    association(:skill_set)
    sequence(:level) { [:junior, :middle, :veteran].sample }
  end
end
