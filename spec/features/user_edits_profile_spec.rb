require 'rails_helper'

feature 'user updates their profile information' do
  # As an authenticated user
  # I want to update my information
  # So that I can keep my profile up to date
  #
  # Acceptance criteria:
  # - I must be able to access the 'edit profile' page from the top bar      displayed on every page
  # - I must be given a notification if my update was successful
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user updates their information' do
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'Edit Profile'
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'newpassword'
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
  end

  scenario 'unathenticated user unable to edit information' do
    visit 'users/sign_in'

    expect(page).to_not have_content('Edit Information')
  end
end
