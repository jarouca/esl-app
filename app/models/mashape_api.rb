class MashapeApi
  BASE_URL = "https://wordsapiv1.p.mashape.com/words/"

  def self.get(url)
    HTTParty.get(
      BASE_URL + url,
      headers:{
      "X-Mashape-Key" => KEY,
      "Accept" => "application/json"
      }
    ).parsed_response
  end
end
