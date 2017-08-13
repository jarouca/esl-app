# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1000.times do
  response = MashapeApi.get("?hasDetails=definitions&random=true")

  if response["word"] &&
    response["results"][0]["partOfSpeech"] &&
    response["results"][0]["definition"]

    RandomWord.create!(
      word: response["word"],
      part_of_speech: response["results"][0]["partOfSpeech"],
      definition: response["results"][0]["definition"]
      )
  end
end
