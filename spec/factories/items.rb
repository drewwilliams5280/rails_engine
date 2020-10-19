FactoryBot.define do
  factory :item do
    id { Faker::Number.unique.between(from: 2484, to: 10000) }
    name { Faker::Lorem.word }
    unit_price { Faker::Number.between(from: 1, to: 1000) }
    merchant_id { Faker::Number.between(from: 1, to: 25) }
    created_at { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
    updated_at { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
  end
end