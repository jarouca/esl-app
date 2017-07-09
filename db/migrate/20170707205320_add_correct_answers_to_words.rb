class AddCorrectAnswersToWords < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :correct_answers, :integer

  end
end
