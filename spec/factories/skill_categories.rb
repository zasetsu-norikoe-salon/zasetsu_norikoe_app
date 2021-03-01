# frozen_string_literal: true

FactoryBot.define do
  factory :skill_category do
    sequence(:name) { Faker::Job.field }
  end
end
