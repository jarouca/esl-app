class Api::V1::WordsController < Api::V1::ApiController

  def create
    @bank = Bank.find(params["bank_id"])
    @word = Word.new
    words = @bank.words
    definition = params["word"].split(",")
    new_word = Word.new(
      word: definition[0],
      definition: definition[2],
      part_of_speech: definition[1],
      bank_id: params["bank_id"]
      )

    if !words.empty?
      words.sort_by { |word| word.total_drills }
      new_word.total_drills = words[0].total_drills
    end

    if new_word.save
      @bank = Bank.find(params["bank_id"])
      @message = "Word added successfully."
    end
  end

  def index
    @bank = Bank.find(params["word"]["bank_id"].to_i)
    @word = Word.new
    @new_word = params["word"]["word"]

    response = MashapeApi.get("#{@new_word}/definitions")

    if response["definitions"].nil?
      @message = 'We did not find any matches for that word. Please check the spelling and try again.'
    else

      @definitions = response["definitions"]

      @message = "We found the following part(s) of speech and definition(s) for '#{@new_word}'. Please select the one you would like to add to your word bank."
    end
  end

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
        "X-Mashape-Key" => KEY,
        "Accept" => "application/json"
        }
      ).parsed_response

      @choices << "(#{response["results"][0]["partOfSpeech"]}), #{response["results"][0]["definition"]}"
    end
    @choices.shuffle!
  end

  respond_to do |format|
    format.js
  end
end
