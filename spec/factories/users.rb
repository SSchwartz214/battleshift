FactoryBot.define do
  factory :user do
    username { 'Reese' }
    email { 'example@example.com' }
    password { 'ducktales' }
    user_token { 0 }
    status { false }
  end
end
