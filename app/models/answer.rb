class Answer < ApplicationRecord
  belongs_to :drill

  validates :drill_id, presence: true, numericality: { only_integer: true }
  validates :word_id, presence: true, numericality: { only_integer: true }
  validates :correct, presence: true 
end
