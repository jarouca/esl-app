require 'rails_helper'

feature 'user adds word to bank' do
  # As an authenticated user
  # I want to add a word to my word bank
  # So I can use the app to study that word

  # Acceptance criteria:

  # - I must be able to add words from the bank#show page
  # - I can only add words to my own bank
  # - I must receive notification that the addition was successful
  # - Upon completion I must be redirected to the bank#show page
  # - if there is more than one word with the same spelling I must be asked to confirm which word I want to select
  # - if more than one word has the same spelling I must be asked to confirm which word I want to select

  scenario 'authenticated user successfully adds a word to their word bank' do

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

    expect(page).to have_content('Word added successfully.')
    expect(page).to have_content('incredible')
  end

  scenario "authenticated user is able to confirm which definition they want to select when they've entered a word that has more than one definition" do

  end

  scenario "authenticated user is able to confirm which word they want to select when they've entered a word that shares the same spelling with other word(s)" do

  end

  scenario "authenticated user mispells word" do
    # we don't have a word matching that, did you mean one of these? maybe API has a search for similarly spelled words to generate a list?
  end

  scenario "authenticated user enter gibberish" do

  end

end
