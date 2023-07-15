class Tutor < ApplicationRecord
  belongs_to :course
  validates :name, presence: true
  validates :contact_number, presence: true, uniqueness: true, length: { is: 10 }
end
