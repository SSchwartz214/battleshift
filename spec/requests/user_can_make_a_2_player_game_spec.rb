require 'rails_helper'

describe 'Battleshift' do
  context '2 player game' do
    it 'can make a two player game' do
      user_1 = User.create(username: 'Seth', email: 'sethster@gmail.com', password_digest: 's', user_token: 'first', status: true)
      user_2 = User.create(username: 'Tristan', email: 'tritan@gmail.com', password_digest: 's', user_token: 'second', status: true)

      post "/api/v1/games?opponent_email=#{user_2.email}", headers: { 'X-API-Key': user_1.user_token, 'CONTENT_TYPE': 'application/json'}
      expect(response).to be_successful
      expect(Game.last[:player_1_key]).to eq('first')
      expect(Game.last[:player_2_key]).to eq('second')
    end
    it 'cannot make game without necessary user info' do
      user_1 = User.create(username: 'Seth', email: 'sethster@gmail.com', password_digest: 's', user_token: 'first', status: true)
      user_2 = User.create(username: 'Tristan', email: 'tritan@gmail.com', password_digest: 's', user_token: 'second', status: true)

    end
  end
end
