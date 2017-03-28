FactoryGirl.define do
  factory :item do

    association :todo, factory: :todo, strategy: :build

    name 'Test'
    done true

  end
end
