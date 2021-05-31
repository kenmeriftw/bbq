FactoryBot.define do
  factory :event do
    association :user
    title { 'FactoryEvent' }
    address { 'FactoryCity' }
    datetime { Time.now }
  end
end
