class Event < ApplicationRecord
  has_and_belongs_to_many :games
  has_and_belongs_to_many :players
  has_and_belongs_to_many :sponsors
  validates :place, :date, presence: true

  scope :find_by_name, -> (my_name) { find_by name: my_name }

end
