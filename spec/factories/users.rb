# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.email(domain: 'example') }
    sequence(:password) { 'password' }
    sequence(:name) { Faker::Name.first_name }
    sequence(:gender) { %i[not_known male female other].sample }
    sequence(:employment_type) { %i[full_time diff_full_time side_biz freelance internship job_seeker].sample }
    sequence(:free_area) { Faker::Lorem.paragraph(sentence_count: rand(5..15), supplemental: true) }
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
      after(:create) do |user|
        # スキル属性を3つ作る
        user.skill_categories << create_list(:skill_category, 3)
        user.skill_categories.each do |skill_category|
          # スキルセットをスキル属性の数×3つ作る
          skill_sets = create_list(:skill_set, 3)
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
