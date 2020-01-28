require 'faker'

FactoryBot.define do
  factory :event do
    title { Faker::Food.dish }
    address { Faker::Address.full_address }
    datetime { Faker::Date.in_date_period }
    description { Faker::Food.description }


    association :user
  end
end
