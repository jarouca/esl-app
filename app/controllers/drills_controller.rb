class DrillsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bank = Bank.find(params["bank_id"])
    if @bank.words.empty?
      redirect_to user_bank_path(current_user, @bank)
    else
    #To ensure each word is drilled an equal amount of times before repeating any word,first sort the words by how many times they've been drilled:
      words = @bank.words
      words.sort_by { |word| word.total_drills }
      #then create a separate bank of any words that have not been drilled as many times as the word that's been drilled the most:
      drill_bank = words.select { |word| word.total_drills < words[-1].total_drills }
      #designate a word for the next flash card based on this information:
      if drill_bank.empty?
        @word = words.sample
      else
        @word = drill_bank.sample
      end
      #retrieve random word definitions from the external API to populate the multiple choice data:
      @choices = []
      @choices << "#{@word.part_of_speech}, #{@word.definition}"
      #retrieve multiple choice definition options from the external API
      2.times do
        response = MashapeApi.get("?hasDetails=definitions&random=true")

        @choices << "(#{response["results"][0]["partOfSpeech"]}), #{response["results"][0]["definition"]}"
      end
      @choices.shuffle!
    end
  end
end
