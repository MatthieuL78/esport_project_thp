class Sponsor < ApplicationRecord
  include DeviseConcern
  has_and_belongs_to_many :events
  has_and_belongs_to_many :games
  has_and_belongs_to_many :players
  mount_uploader :avatar, AvatarUploader
end
