require 'rails_helper'

feature 'user deletes word form bank' do

  # As an authenticated user
  # I want to delete a word from my word bank
  # So I can keep my word bank up to date with words I want to study
  #
  # Acceptance criteria:
  #
  # - I can only delete words from my own bank
  # - I must receive notification that the deletion was successful
  # - Upon completion I must be redirected to the bank#show page

  scenario 'authenticated user deletes word from bank' do
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
    click_link 'Delete Word'

    expect(page).to have_content('Word deleted successfully.')
    expect(page).to_not have_content('incredible')
    expect(page).to_not have_content('(adjective), beyond belief or understanding')
  end
end
