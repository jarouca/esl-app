class AddWordToWords < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :word, :string
  end
end
