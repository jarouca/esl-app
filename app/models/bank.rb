class Bank < ApplicationRecord
  has_and_belongs_to_many :words
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :user_id, presence: true, numericality: { only_integer: true }

end
