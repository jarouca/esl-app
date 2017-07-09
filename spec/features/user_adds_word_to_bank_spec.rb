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
    click_button 'Add Word'
    expect(page).to have_content("We found the following part(s) of speech and definition(s) for 'incredible'. Please select the one you would like to add to your word bank.")
    choose("word_incredible___adjective___beyond_belief_or_understanding")
    click_button 'Add Word'

    expect(page).to have_content('Word added successfully.')
    expect(page).to have_content('incredible')
    expect(page).to have_content('(adjective), beyond belief or understanding')
  end

  scenario "authenticated user is able to confirm which definition they want to select when they've entered a word that has more than one definition" do
    user = FactoryGirl.create(:user)
    bank = FactoryGirl.create(:bank, user_id: user.id)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'View My Word Banks'
    click_link bank.title
    fill_in 'Add Word', with: 'boat'
    click_button 'Add Word'

    expect(page).to have_content("We found the following part(s) of speech and definition(s) for 'boat'. Please select the one you would like to add to your word bank.")
    expect(page).to have_content('(noun), a small vessel for travel on water')
    expect(page).to have_content('(noun), a dish (often boat-shaped) for serving gravy or sauce')
    expect(page).to have_content('(verb), ride in a boat on water')

    choose("word_boat___noun___a_small_vessel_for_travel_on_water")
    click_button 'Add Word'
    expect(page).to have_content('Word added successfully.')
    expect(page).to have_content('boat - (noun), a small vessel for travel on water')
  end

  scenario "authenticated user mispells word" do
    user = FactoryGirl.create(:user)
    bank = FactoryGirl.create(:bank, user_id: user.id)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'View My Word Banks'
    click_link bank.title
    fill_in 'Add Word', with: 'ahjsgfshj'
    click_button 'Add Word'

    expect(page).to have_content('We did not find any matches for that word. Please check the spelling and try again')
  end

  scenario "authenticated user enters a blank string" do
    user = FactoryGirl.create(:user)
    bank = FactoryGirl.create(:bank, user_id: user.id)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'View My Word Banks'
    click_link bank.title
    fill_in 'Add Word', with: ''
    click_button 'Add Word'

    expect(page).to have_content('We did not find any matches for that word. Please check the spelling and try again')
  end

end
