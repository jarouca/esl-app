require 'rails_helper'

feature 'user creates an account' do
  # As a prospective user
  # I want to create a profile
  # So that I can use the app
  #
  # Acceptance criteria:
  # - I must be able to access the sign up form from the root
  # - I must provide an email address
  # - I must provide a username and password
  # - I must confirm my password
  # - I must be given notification if my creation was succesfful

  scenario 'user successfully creates an account' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Username', with: 'username'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Your registration was successful, thank you.")
    expect(page).to have_content("Sign Out")
  end

  scenario 'required information is not supplied' do
    visit '/users/sign_up'
    click_link 'Sign Up'
    click_button "Sign Up"

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password confirmation does not match password' do
    visit '/users/sign_up'
    click_link 'Sign Up'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'assword'
    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
