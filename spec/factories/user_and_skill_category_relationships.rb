# frozen_string_literal: true

FactoryBot.define do
  factory :user_and_skill_category_relationship do
    association(:user)
    association(:skill_category)
  end
end
