class CreateRandomWords < ActiveRecord::Migration[5.0]
  def change
    create_table :random_words do |t|
      t.string :word, null: false
      t.string :part_of_speech, null: false
      t.string :definition, null: false
    end
  end
end
