require 'rails_helper'

feature 'user deletes a bank' do
  # As an authenticated user
  # I want to delete my bank
  # So I can remove it from my profile if I am done studying those words
  #
  # Acceptance criteria:
  # - I can only delete banks that I own
  # - I must receive notification that the deletion was successful

  let!(:user) { FactoryGirl.create(:user) }
  let!(:bank) { FactoryGirl.create(:bank, user_id: user.id) }

  scenario 'authenticated user successfully deletes a word bank' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'View My Word Banks'
    click_link bank.title
    click_link 'Delete Bank'

    expect(page).to_not have_content(bank.title)
    expect(page).to have_content('Bank deleted successfully')
  end
end
