class Event < ApplicationRecord
  has_and_belongs_to_many :games
  has_and_belongs_to_many :players
  has_and_belongs_to_many :sponsors
end
