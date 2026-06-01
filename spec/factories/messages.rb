FactoryBot.define do
  factory :message do
    association :conversation
    association :user
    content { "MyText" }
  end
end
