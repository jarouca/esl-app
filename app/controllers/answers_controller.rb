class AnswersController < ApplicationController
  def create
    word = Word.find(params["word_id"])
    if params["choice"] == word.part_of_speech + "," + word.definition

      answer = Answer.new(drill_id: params["drill_id"], word_id: params["word_id"], correct: true)

      answer.save

      flash[:notice] = "Correct!"
    else
      answer = Answer.new(drill_id: params["drill_id"], word_id: params["word_id"], correct: false)

      flash[:notice] = "Incorrect"
    end
  end
end
