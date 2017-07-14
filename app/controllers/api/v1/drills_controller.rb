class Api::V1::DrillsController < Api::V1::ApiController
  def index
    bank = Bank.find(params["bank_id"])
    words = bank.words
    words.sort_by { |word| word.total_drills }
    drill_bank = words.select { |word| word.total_drills < words[-1].total_drills }

    if drill_bank.empty?
      word = words.sample
    else
      word = drill_bank.sample
    end

    choices = []
    choices << "#{@word.part_of_speech}, #{@word.definition}"

    2.times do
      response = HTTParty.get(
        "https://wordsapiv1.p.mashape.com/words/?hasDetails=definitions&random=true",
        headers:{
        "X-Mashape-Key" => "i0cjA2j435mshSHKQEDvu6jNERWzp1wNjlRjsnxXRFfpg0il5D",
        "Accept" => "application/json"
        }
      ).parsed_response

      choices << "(#{response["results"][0]["partOfSpeech"]}), #{response["results"][0]["definition"]}"
    end
    choices.shuffle!

    render json: {
      choices: choices,
      word: word
    }
  end
end
