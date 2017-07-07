require 'rails_helper'

feature 'flash card drill words from word bank' do
  # As an authenticated user
  # I want to flash card drill words from my word bank
  # So I can study these words and expand my vocabulary
  #
  # Acceptance Criteria: 
  # - I will be asked to select the definition of a word randomly selected from my word bank
  # - I will select the part of speech and definition from multiple choice
  # - The other choices will be generated randomly by the app
  # - I will be told if I am correct or incorrect
  # - Every word from my word bank will be drilled before repeating any words, this pattern will continue for every round of drilling

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
    choose("choice___adjective____beyond_belief_or_understanding")

    click_button 'Submit Answer'
    expect(page).to have_content('Correct!')
  end

  scenario 'user selects incorrect definition for vocabulary word' do
  end

  scenario 'word is not repeated until all words have been driller' do
    # create bank w/ 2 words, one of them having total answer pre prgrammed to 1, expect word to not be that word
  end
end
