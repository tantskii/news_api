FactoryGirl.define do
  factory :user do
    password {"1234"}

    sequence(:username) {"user#{rand(10000)}"}
  end
end
