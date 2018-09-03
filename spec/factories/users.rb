FactoryBot.define do
  factory :user do
    username { 'eddie_brock' }
    email { 'spiderman2isbetterthanspidermanhomecoming@doctoroctopus.com' }
    password { 'ducktales' }
    user_token { '007' }
    status { true }

    factory :user_2 do
      username { 'wade_wilson' }
      email { 'doctor@octagonapus.com' }
      password { 'darkwing_duck' }
      user_token { '009' }
      status { true }
    end
  end
end
