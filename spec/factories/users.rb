# FactoryBot.define do
#   factory :user do
#     username { "testuser1" }
#     email { "test1@example.com" }
#     password { "password@123r" }
#   end
# end
FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "testuser#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { Faker::Internet.password(min_length: 8) }
  end
end
