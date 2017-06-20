class Bank < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :words

  validates :title, presence: true, length: { maximum: 100 }
  validates :user_id, presence: true, numericality: { only_integer: true }

end
