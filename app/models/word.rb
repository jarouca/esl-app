class Word < ApplicationRecord
  has_and_belongs_to_many :banks

  validates :word, presence: true
  validates :part_of_speech, presence: true
  validates :definition, presence: true
end
