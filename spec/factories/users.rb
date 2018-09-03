FactoryBot.define do
  factory :user do
    username { 'eddie_brock' }
    email { 'something@something.com' }
    password_digest { 'ducktales' }
    user_token { '007' }
    status { true }
    identifier { '007' }

    factory :user_2 do
      username { 'wade_wilson' }
      email { 'doctor@octagonapus.com' }
      password_digest { 'darkwing_duck' }
      user_token { '009' }
      status { true }
      identifier { '009' }
    end
  end
end
