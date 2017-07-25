FactoryGirl.define do
  factory :news do
    association :user

    datetime DateTime.now
    сontent 'Donald Trump on Tuesday condemned Jeff Sessions'
    title 'politics'
    sources %w(bbc NYT guardian)
  end
end

