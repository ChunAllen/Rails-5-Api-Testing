FactoryGirl.define do
  factory :todo do
    title 'Test'

    created_by 'Test'

    trait :with_items do
      after(:build) do |tody|
        todo.items << build(:item)
      end

      after(:create) do |tody|
        todo.items << build(:item)
      end
    end

    trait :invalid do
      title nil
    end

  end
end
