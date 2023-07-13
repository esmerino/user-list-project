FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    age { rand(1..35) }
    email { Faker::Internet.email }    
  end
end
