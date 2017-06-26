require 'rails_helper'

feature 'user deletes a bank' do
  # As an authenticated user
  # I want to delete my bank
  # So I can remove it from my profile if I am done studying those words
  #
  # Acceptance criteria:
  # - I can only delete banks that I own
  # - I must receive notification that the deletion was successful

  scenario 'authenticated user successfully deletes a word bank' do
    user = FactoryGirl.create(:user)
    bank = FactoryGirl.create(:bank, user_id: user.id)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'View My Word Banks'
    click_link bank.title
    click_link 'Delete Bank'

    expect(page).to_not have_content(bank.title)
    expect(page).to have_content('Bank deleted successfully')
  end
end
