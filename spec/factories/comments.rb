FactoryBot.define do
  factory :comment do
    tweet_comment { Faker::Lorem.characters(number:20)}
    user
    tweet
  end
end