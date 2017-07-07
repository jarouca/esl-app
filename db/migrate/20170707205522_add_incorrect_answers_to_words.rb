class AddIncorrectAnswersToWords < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :incorrect_answers, :integer

  end
end
