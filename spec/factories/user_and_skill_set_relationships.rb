# frozen_string_literal: true

FactoryBot.define do
  factory :user_and_skill_set_relationship do
    association(:user)
    association(:skill_set)
    sequence(:level) { Faker::Number.within(range: 1..3) }
  end
end
