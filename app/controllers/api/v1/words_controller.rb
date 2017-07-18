class Api::V1::WordsController < Api::V1::ApiController

  def update
    if params["choice"].nil?
      @notice = "Please be sure to select a definition"
    else
      word = Word.find(params["word"]["word_id"].to_i)
      if params["choice"].split(",")[1].strip! == word.definition.strip
        word.correct_answers += 1
        @notice = "Correct! Try this word next:"
      else
        word.incorrect_answers += 1
        @notice = "Incorrect, try this word next:"
      end
      word.total_drills += 1
      word.save
    end
    @bank = Bank.find(params["word"]["bank_id"].to_i)
    #ensure every word is drilled an equal amount of times
    words = @bank.words
    words.sort_by { |word| word.total_drills }
    drill_bank = words.select { |word| word.total_drills < words[-1].total_drills }

    if drill_bank.empty?
      @word = words.sample
    else
      @word = drill_bank.sample
    end

    @choices = []
    @choices << "#{@word.part_of_speech}, #{@word.definition}"
    #retrieve multiple choice definition options from the external API
    2.times do
      response = HTTParty.get(
        "https://wordsapiv1.p.mashape.com/words/?hasDetails=definitions&random=true",
        headers:{
        "X-Mashape-Key" => "i0cjA2j435mshSHKQEDvu6jNERWzp1wNjlRjsnxXRFfpg0il5D",
        "Accept" => "application/json"
        }
      ).parsed_response

      @choices << "(#{response["results"][0]["partOfSpeech"]}), #{response["results"][0]["definition"]}"
    end
    @choices.shuffle!

    # render json: {
    #   notice: notice,
    #   choices: @choices,
    #   word: @word,
    #   bank: @bank
    # }

    respond_to do |format|
      format.js
      # <%= render 'shared/update_word', bank: @bank, word: @word, choices: @choices %>

    end
  end
end
