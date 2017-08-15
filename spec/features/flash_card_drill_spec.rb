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

  20.times do
    response = MashapeApi.get("?hasDetails=definitions&random=true")

    if response["word"] &&
      response["results"][0]["partOfSpeech"] &&
      response["results"][0]["definition"]

      RandomWord.find_or_create_by!(
        word: response["word"],
        part_of_speech: response["results"][0]["partOfSpeech"],
        definition: response["results"][0]["definition"]
        )
    end
  end

  let!(:user) { FactoryGirl.create(:user) }
  let!(:bank) { FactoryGirl.create(:bank, user_id: user.id) }
  let!(:word) { FactoryGirl.create(:word, bank: bank, part_of_speech: "(adjective)", definition: " beyond belief or understanding")}
  let!(:second_word) { FactoryGirl.create(:word, bank: bank, total_drills: 1) }

  scenario 'user selects correct definition for vocabulary word' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'View My Word Banks'
    click_link bank.title
    click_link 'Drill Vocabulary Words'
    choose("choice__adjective____beyond_belief_or_understanding")

    click_button 'Submit Answer'
    expect(page).to have_content('Correct!')
  end

  scenario 'a word is not repeated until all words have been drilled' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'View My Word Banks'
    click_link bank.title
    click_link 'Drill Vocabulary Words'

    expect(page).to_not have_content(second_word.word)
  end

  scenario 'user fails to select a definition' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'View My Word Banks'
    click_link bank.title
    click_link 'Drill Vocabulary Words'

    click_button 'Submit Answer'
    expect(page).to have_content("Please be sure to select a definition")
  end
end
