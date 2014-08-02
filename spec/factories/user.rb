FactoryGirl.define do
  factory :user do
    association :hoges, factory: :hoge
  end
end