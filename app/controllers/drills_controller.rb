class DrillsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bank = Bank.find(params["bank_id"])
    #ensure that each word is drilled an equal amount of times
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
  end
end
