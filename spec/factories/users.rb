# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.email(domain: 'example') }
    sequence(:password) { 'password' }
    sequence(:name) { Faker::Name.name }
    sequence(:gender) { User.enumerized_attributes[:gender].values.sample }
    sequence(:employment_type) { User.enumerized_attributes[:employment_type].values.sample }
    sequence(:zasetsu_count) { Faker::Number.digit }

    # スキル属性とスキルセットも一緒に作成する
    trait :with_skill_sets do
      after(:create) do |user|
        user_and_skill_set = create(:user_and_skill_set_relationship, user: user)
        skill_category = user_and_skill_set.skill_set.skill_category
        create(:user_and_skill_category_relationship, user: user, skill_category: skill_category)
      end
    end

    trait :for_seed do
      sequence(:age) { %w[10s 20s 30s 40s 50s 60s 70s 80s 90s].sample }
      sequence(:prefecture) { Faker::Address.city }
      sequence(:available_work_time) do
        "#{rand(0..12)}時~#{rand(13..24)}時"
      end
      sequence(:qualification) { Faker::JapaneseMedia::Naruto.eye }
      sequence(:hobby) { Faker::Alphanumeric.alpha(number: 10) }
      sequence(:special_skill) { Faker::Job.field }
      sequence(:want_talk) { Faker::Movie.title }
      sequence(:not_want_talk) { Faker::Movie.title }
      sequence(:free_area) { Faker::Lorem.paragraph(sentence_count: rand(5..15), supplemental: true) }
      sequence(:facebook_url) { Faker::Internet.url(host: 'facebook.com') }
      sequence(:insta_url) { Faker::Internet.url(host: 'instagram.com') }
      sequence(:twitter_url) { Faker::Internet.url(host: 'twitter.com') }
      sequence(:github_url) { Faker::Internet.url(host: 'github.com') }
      sequence(:port_url) { Faker::Internet.url(host: 'example.com') }
      after(:create) do |user|
        # スキル属性を3つ作る
        user.skill_categories << create_list(:skill_category, rand(1..5))
        user.skill_categories.each do |skill_category|
          # スキルセットをスキル属性の数×3つ作る
          skill_sets = create_list(:skill_set, rand(1..5))
          skill_sets.each do |skill_set|
            # 作ったスキル属性にスキルセットを登録し、ユーザーに紐付ける
            skill_category.skill_sets << skill_set
            create(:user_and_skill_set_relationship, user: user, skill_set: skill_set)
          end
        end
      end
    end
  end
end
