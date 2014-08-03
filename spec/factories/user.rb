FactoryGirl.define do
  factory :user do
    hoges { build_list :hoge, 3 }
  end
end