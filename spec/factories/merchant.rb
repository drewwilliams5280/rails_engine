FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name_with_middle }
    created_at { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
    updated_at { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
  end
end