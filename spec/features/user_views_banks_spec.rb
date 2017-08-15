require 'rails_helper'

feature 'user views a list of all of their banks' do
  # As an authenticated user
  # I want to view a list of my word banks
  # So I can see all the banks I've created
  let!(:user) { FactoryGirl.create(:user) }
  let!(:first_bank) { FactoryGirl.create(:bank, user_id: user.id) }
  let! (:second_bank) { FactoryGirl.create(:bank, user_id: user.id) }
  let! (:third_bank) { FactoryGirl.create(:bank, user_id: user.id) }
  let! (:fourth_bank) { FactoryGirl.create(:bank, user_id: user.id) }

  scenario 'user successfully views list of their word banks' do

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'View My Word Banks'

    expect(page).to have_content(first_bank.title)
    expect(page).to have_content(second_bank.title)
    expect(page).to have_content(third_bank.title)
    expect(page).to have_content(fourth_bank.title)
  end
end
