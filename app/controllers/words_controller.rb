class WordsController < ApplicationController
#params["choice"]
#params["word_id"]
#params["id"]
  def update
    word = Word.find(params["id"])
    if params["choice"].split(",")[1].strip! == word.definition.strip!
      word.correct_answers += 1
      flash[:notice] = "Correct!"
    else
      word.incorrect_answers += 1
      flash[:notice] = "Incorrect"
    end
    word.total_drills += 1
    redirect_to bank_drills_path
  end

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
    words = @bank.words
    definition = params["word"].split(",")
    word = Word.new(
      word: definition[0],
      definition: definition[2],
      part_of_speech: definition[1],
      bank_id: params["bank_id"]
      )

    if !words.empty?
      words.sort_by! { |word| word.total_drills }
      word.total_drills = words[0].total_drills
    end

    if word.save
      flash[:notice] = "Word added successfully."
      redirect_to @bank
    end
  end

  def destroy
    @bank = Bank.find(params["bank_id"])
    word = Word.find(params["id"])

    if @bank.user_id == current_user.id
      word.destroy
      flash[:notice] = "Word deleted successfully."
      redirect_to @bank
    end
  end
end
