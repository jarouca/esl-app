FactoryGirl.define do
  factory :word do
    sequence(:word) { |n| "#{n}word" }
    sequence(:definition) { |n| "#{n}word"}
    part_of_speech 'v'

    association :bank, factory: :bank
  end
end
