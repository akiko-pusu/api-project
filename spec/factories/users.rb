FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "ユーザー#{n}" }
  end
end
