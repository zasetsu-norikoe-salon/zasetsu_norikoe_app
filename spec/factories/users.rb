# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.email(domain: 'example') }
    sequence(:password) { 'password' }
    sequence(:name) { Faker::Name.first_name }
    sequence(:gender) { %i[not_known male female other].sample }
    sequence(:employment_type) { %i[full_time diff_full_time side_biz freelance internship job_seeker].sample }
    sequence(:zasetsu_count) { Faker::Number.digit }

    # スキル属性も一緒に作成する
    trait :with_skill_categories do
      after(:create) do |user|
        create(:user_and_skill_category_relationship, user: user)
      end
    end

    # スキルセットも一緒に作成する
    trait :with_skill_sets do
      after(:create) do |user|
        create(:user_and_skill_set_relationship, user: user)
      end
    end
  end
end
