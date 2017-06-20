class Word < ApplicationRecord
  has_and_belongs_to_many :banks

  validates :part_of_speech, presence: true
  validates :definition, presence: true
end
