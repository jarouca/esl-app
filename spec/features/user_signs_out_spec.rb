require 'rails_helper'

feature 'user signs out' do
  # As an authenticated user
  # I want to sign out
  # So that no one else can use my profile
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user signs out' do
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'Sign Out'

    expect(page).to have_content('Signed out successfully.')
    expect(page).to_not have_content('Sign Out')
  end
end
