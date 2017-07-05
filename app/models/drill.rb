class Drill < ApplicationRecord
  has_many :answers
  belongs_to :bank

  validates :bank_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
end
