FactoryGirl.define do
  factory :todo do
    title { Faker::Lorem.word }
    completed { false }
    order { 0 }
  end
end
