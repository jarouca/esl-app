class RandomWord < ApplicationRecord
  validates :word, presence: true
  validates :part_of_speech, presence: true
  validates :definition, presence: true
end
