class Word < ApplicationRecord
  belongs_to :bank
  after_initialize :init

  validates :word, presence: true
  validates :part_of_speech, presence: true
  validates :definition, presence: true

  def init
    self.correct_answers ||= 0
    self.incorrect_answers ||= 0
    self.total_drills ||= 0
  end
end
