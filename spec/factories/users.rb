FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.free_email }
    sequence(:password) { 'password' }
    sequence(:name) { Faker::Name.first_name}
    sequence(:gender) { Faker::Number.within(range: 1..4) }
    sequence(:employment_form) { Faker::Number.within(range: 1..5) }
    sequence(:zasetsu_count) { Faker::Number.digit }
  end
end
