# frozen_string_literal: true

FactoryBot.define do
  factory :skill_category do
    sequence(:name) { Faker::Job.field }

    # Userも一緒に作成する
    trait :with_users do
      after(:create) do |skill_category|
        create(:user_and_skill_category_relationship, skill_category: skill_category)
      end
    end
  end
end
