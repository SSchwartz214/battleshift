require 'rails_helper'

describe 'a user' do
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  context 'after registration' do
    it 'can have their status changed to active via email' do
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
      expect(page).to have_content("This account has not yet been activated. Please check your email")

      user = User.first
      user_email = open_email_for(user.email)
      binding.pry
      expect(user_email).to have_subject('Activate your Battleshift account!')
      expect(user_email).to have_body_text('click here to activate')

      click_on 'click here to activate your account'

      expect(page).to have_content('Status: Active')
    end
  end
end
