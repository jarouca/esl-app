class DropWordsBanks < ActiveRecord::Migration[5.0]
  def change
    drop_table :banks_words
  end
end
