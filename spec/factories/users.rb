FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@bar.baz" }
    password  { "password123" }
  end
end
