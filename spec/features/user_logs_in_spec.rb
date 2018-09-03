require 'rails_helper'

describe ' a user' do
  context 'registers for an account' do
    it 'can create account and login' do
      name = 'Larry'
      email = 'l3@aol.com'
      password = 'woopdoop'

      visit '/'

      click_on 'Register'

      expect(current_path).to eq('/register')

      fill_in :user_username, with: name
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password
      click_on 'Submit'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Logged in as #{name}")
      expect(page).to have_content("This account has not yet been activated. Please check your email")
    end
  end

  it "can login with an existing account" do
    user = create(:user)

     visit '/'

     click_on "I already have an account"

     expect(current_path).to eq(login_path)
     fill_in "username", with: user.username
     fill_in "password", with: user.password

     click_on "Log In"

     expect(current_path).to eq(dashboard_path)

     expect(page).to have_content("Logged in as #{user.username}")
     expect(page).to have_content("Log out")
   end
 end
