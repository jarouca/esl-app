class AnswersController < ApplicationController
  def index
    @answer = Answer.new
    @bank = Bank.find(params["bank_id"])
    @word = @bank.words.sample
    @choices = []
    @choices << "(#{@word.part_of_speech}), #{@word.definition}"

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
  end
end

#response["word"]
#response["results"][0]["definition"]
#response["results"][0]["partOfSpeech"]
