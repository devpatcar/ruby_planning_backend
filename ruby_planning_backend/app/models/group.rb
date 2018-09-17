class Group < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :tasks
  has_many :schedulings
  validates :name, presence: true, uniqueness: true
end
