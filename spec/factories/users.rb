# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.free_email }
    sequence(:password) { 'password' }
    sequence(:name) { Faker::Name.first_name }
    sequence(:gender) { [:not_known, :male, :female, :other].sample }
    sequence(:employment_form) { Faker::Number.within(range: 1..5) } # TODO: Enumを設定したら合わせて変更する
    sequence(:zasetsu_count) { Faker::Number.digit }
  end
end
