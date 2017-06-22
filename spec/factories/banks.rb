FactoryGirl.define do
  factory :bank do
    sequence(:title) { |n| "#{n}title" }

    association :user, factory: :user
  end
end
