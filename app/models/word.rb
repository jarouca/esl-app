class Word < ApplicationRecord
  belongs_to :bank

  validates :word, presence: true
  validates :part_of_speech, presence: true
  validates :definition, presence: true
end
