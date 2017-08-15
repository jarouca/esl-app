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
    login_as(user, :scope => :user)
    visit root_path
    click_link 'View My Word Banks'

    expect(page).to have_content(first_bank.title)
    expect(page).to have_content(second_bank.title)
    expect(page).to have_content(third_bank.title)
    expect(page).to have_content(fourth_bank.title)
  end
end
