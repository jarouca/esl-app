class CreateBanksAndWords < ActiveRecord::Migration[5.0]
  def change
    create_table :banks do |t|
      t.string :title, null: false
      t.integer :user_id, null: false
    end

    create_table :words do |t|
      t.string :part_of_speech, null: false
      t.string :definition, null: false
    end

    create_table :banks_words, id: false do |t|
      t.belongs_to :bank
      t.belongs_to :word
    end
  end
end
