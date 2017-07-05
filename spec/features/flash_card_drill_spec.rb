require 'rails_helper'

feature 'flash card drill words from word bank' do
  scenario 'user selects correct definition for vocabulary word' do
    user = FactoryGirl.create(:user)
    bank = FactoryGirl.create(:bank, user_id: user.id)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'View My Word Banks'
    click_link bank.title
    fill_in 'Add Word', with: 'incredible'
    click_button 'Create Word'
    expect(page).to have_content("We found the following part(s) of speech and definition(s) for 'incredible'. Please select the one you would like to add to your word bank.")
    choose("word_incredible___adjective___beyond_belief_or_understanding")
    click_button 'Create Word'
    click_link 'Drill Vocabulary Words'
    choose("word_incredible___adjective___beyond_belief_or_understanding")

    expect(page).to have_content('Correct!')
  end

  scenario 'user selects incorrect definition for vocabulary word' do
  end
end
