require 'rails_helper'

feature 'user updates a bank' do
  # As an authenticated user
  # I want to update a bank's title
  # So that I can correct errors or provide new information
  #
  # Acceptance Criteria:
  # * I must be signed in to edit a word bank
  # * I must be able to access the update page the bank's show page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:bank) { FactoryGirl.create(:bank, user_id: user.id) }

  scenario 'user successfully updates a submission' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'View My Word Banks'
    click_link bank.title
    click_link 'Edit Bank'
    fill_in 'Title', with: 'new bank title'
    click_button 'Update Bank'

    expect(page).to have_content('Bank successfully updated.')
    expect(page).to have_content('new bank title')
  end

  scenario 'user fails to provide required information' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'View My Word Banks'
    click_link bank.title
    click_link 'Edit Bank'
    fill_in 'Title', with: ''
    click_button 'Update Bank'

    expect(page).to have_content("Title can't be blank")
  end
end
