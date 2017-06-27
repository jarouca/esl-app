class WordsController < ApplicationController

  def create
    @bank = Bank.find(params["bank_id"])

    new_word = params["word"]["word"]

    response = HTTParty.get(
      "https://wordsapiv1.p.mashape.com/words/#{new_word}/definitions",
      headers:{
      "X-Mashape-Key" => "i0cjA2j435mshSHKQEDvu6jNERWzp1wNjlRjsnxXRFfpg0il5D",
      "Accept" => "application/json"
      }
    ).parsed_response

    if @bank.words << Word.new(
      word: new_word,
      definition: response["definitions"][0]["definition"],
      part_of_speech: response["definitions"][0]["partOfSpeech"]
      )

      flash[:notice] = "Word added successfully."
      redirect_to @bank
    end


  end
end

# params["bank_id"]
# response["word"]
# response["definitions"][0]["definition"]
# response["definitions"][0]["partOfSpeech"]
