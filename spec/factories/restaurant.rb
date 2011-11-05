FactoryGirl.define do
  factory :restaurant do
    sequence(:name) { |n| "Restaurant #{n}" }
    latitude 0
    longitude 0
  end
end