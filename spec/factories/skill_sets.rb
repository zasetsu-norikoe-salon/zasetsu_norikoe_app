# frozen_string_literal: true

FactoryBot.define do
  # ランダム（プログラミング言語、アプリ名、OS名）
  factory :skill_set do
    sequence(:name) do
      [
        Faker::Computer.os,
        Faker::ProgrammingLanguage.name,
        Faker::App.name
      ].sample
    end
  end

  # プログラミング言語
  factory :pg_lang, class: 'SkillSet' do
    sequence(:name) { Faker::ProgrammingLanguage.name }
  end

  # アプリの名前
  factory :app_name, class: 'SkillSet' do
    sequence(:name) { Faker::App.name }
  end

  # OSの名前
  factory :os, class: 'SkillSet' do
    sequence(:name) { Faker::Computer.os }
  end
end
