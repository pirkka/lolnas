FactoryGirl.define do
  factory :lunch do
    sequence(:title) { |n| "Lunch #{n}" }

    restaurant
  end
end