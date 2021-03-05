# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.email(domain: 'example') }
    sequence(:password) { 'password' }
    sequence(:name) { Faker::Name.first_name }
    sequence(:gender) { %i[not_known male female other].sample }
    sequence(:employment_type) { %i[full_time diff_full_time side_biz freelance internship job_seeker].sample }
    sequence(:zasetsu_count) { Faker::Number.digit }

    after(:create) do |user|
      create(:user_and_skill_category_relationship, user: user)
      create(:user_and_skill_set_relationship, user: user)
    end
  end
end
