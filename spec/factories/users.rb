# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.free_email }
    sequence(:password) { 'password' }
    sequence(:name) { Faker::Name.first_name }
    sequence(:gender) { [:not_known, :male, :female, :other].sample }
    sequence(:employment_form) { [:full_time, :diff_full_time, :side_biz, :freelance, :internship, :job_seeker].sample }
    sequence(:zasetsu_count) { Faker::Number.digit }
  end
end
