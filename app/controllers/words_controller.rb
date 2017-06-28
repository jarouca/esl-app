class WordsController < ApplicationController
  # response["definitions"].length
  # response["definitions"][0]["definition"]
  # response["definitions"].each {|definition|puts definition["partOfSpeech"]+ definition["definition"] }

  def index
    @bank = Bank.find(params["bank_id"])
    @word = Word.new
    @new_word = params["word"]["word"]
    response = nil

    response = HTTParty.get(
      "https://wordsapiv1.p.mashape.com/words/#{@new_word}/definitions",
      headers:{
      "X-Mashape-Key" => "i0cjA2j435mshSHKQEDvu6jNERWzp1wNjlRjsnxXRFfpg0il5D",
      "Accept" => "application/json"
      }
    ).parsed_response

    if response["definitions"].nil?
      flash[:notice] = 'We did not find any matches for that word. Please check the spelling and try again'

      redirect_to user_bank_path(current_user, @bank)
    end

    @definitions = response["definitions"]

    @message = "We found the following part(s) of speech and definition(s) for '#{@new_word}'. Please select the one you would like to add to your word bank."
  end

  def create
    @bank = Bank.find(params["bank_id"])

    definition = params["word"].split(",")

    if @bank.words << Word.new(
      word: definition[0],
      definition: definition[2],
      part_of_speech: definition[1]
      )

      flash[:notice] = "Word added successfully."
      redirect_to @bank
    end
  end

end
