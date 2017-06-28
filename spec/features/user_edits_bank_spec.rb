require 'rails_helper'

feature 'user updates a bank' do
  # As an authenticated user
  # I want to update a bank's title
  # So that I can correct errors or provide new information
  #
  # Acceptance Criteria:
  # * I must be signed in to edit a word bank
  # * I must be able to access the update page the bank's show page

  scenario 'user successfully updates a submission' do
    user = FactoryGirl.create(:user)
    bank = FactoryGirl.create(:bank, user_id: user.id)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'View My Word Banks'
    click_link bank.title
    click_link 'Edit Bank'
    fill_in 'Title', with: 'new bank title'
    click_button 'Update Bank'

    expect(page).to have_content('Bank successfully updated.')
    expect(page).to have_content('new bank title')
  end

  scenario 'user fails to provide required information' do
    user = FactoryGirl.create(:user)
    bank = FactoryGirl.create(:bank, user_id: user.id)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'View My Word Banks'
    click_link bank.title
    click_link 'Edit Bank'
    fill_in 'Title', with: ''
    click_button 'Update Bank'

    expect(page).to have_content("Title can't be blank")
  end
end
