class DrillsController < ApplicationController
  def index
    @bank = Bank.find(params["bank_id"])
    @word = @bank.words.sample
    @answers = []
    @answers << "(#{@word.part_of_speech}), #{@word.definition}"

    2.times do
      response = HTTParty.get(
        "https://wordsapiv1.p.mashape.com/words/?hasDetails=definitions&random=true",
        headers:{
        "X-Mashape-Key" => "i0cjA2j435mshSHKQEDvu6jNERWzp1wNjlRjsnxXRFfpg0il5D",
        "Accept" => "application/json"
        }
      ).parsed_response

      @answers << "(#{response["results"][0]["partOfSpeech"]}), #{response["results"][0]["definition"]}"
    end

  end
end

#response["word"]
#response["results"][0]["definition"]
#response["results"][0]["partOfSpeech"]
