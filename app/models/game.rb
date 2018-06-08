class Game < ApplicationRecord
  has_and_belongs_to_many :events
  has_and_belongs_to_many :players
  has_and_belongs_to_many :sponsors
  validates :name, :type, presence: true
end
