FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "testuser#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { Faker::Internet.password(min_length: 8) }
    admin { false }
    reset_token { SecureRandom.urlsafe_base64 }
    reset_sent_at { Time.now }
  end
end
