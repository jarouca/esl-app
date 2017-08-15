require 'rails_helper'

feature 'user signs out' do
  # As an authenticated user
  # I want to sign out
  # So that no one else can use my profile
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user signs out' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'Sign Out'

    expect(page).to have_content('Signed out successfully.')
    expect(page).to_not have_content('Sign Out')
  end
end
