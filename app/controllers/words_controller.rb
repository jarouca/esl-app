
class WordsController < ApplicationController
skip_before_action :verify_authenticity_token

  def create

    response = Unirest.get        "https://wordsapiv1.p.mashape.com/words/incredible/definitions",
      headers:{
        "X-Mashape-Key": "i0cjA2j435mshSHKQEDvu6jNERWzp1wNjlRjsnxXRFfpg0il5D",
        "Accept": "application/json"
      }
      binding.pry
  end
end
