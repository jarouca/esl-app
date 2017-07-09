class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.integer :drill_id, null: false
      t.integer :word_id, null: false
      t.boolean :correct, null: false
    end
  end
end
