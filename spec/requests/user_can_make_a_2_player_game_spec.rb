require 'rails_helper'

describe 'Battleshift' do
  context '2 player game' do
    it 'can make a two player game' do
      user_1 = User.create(username: 'Seth', email: 'sschwartz214@gmail.com', password_digest: 's', user_token: 'AyYClax4fvejaSjrdtfQ3Q', status: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      get '/dashboard'
      expect(response).to be_successful


    end
  end
end
