require 'rails_helper'

feature 'user creates a bank' do
  # As an authenticated user
  # I want to create a bank
  # So I can specify which words I want to study
  #
  # Acceptance criteria:
  # - I must provide a bank title
  # - I can create more than one bank (maybe I should set a limit on how many banks a user can have at one time?)
  # - if creation is successful I must be directed to the user's bank#index page
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user successfully creates a bank' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'Create Word Bank'
    fill_in 'Title', with: 'Level 3 Vocabulary'

    click_button 'Create Bank'
    expect(page).to have_content('Bank successfully created.')
  end

  scenario 'user does not supply required information' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'Create Word Bank'

    click_button 'Create Bank'
    expect(page).to have_content("Title can't be blank")
  end
end
