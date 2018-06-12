class Player < ApplicationRecord
  include DeviseConcern
  has_and_belongs_to_many :events
  has_and_belongs_to_many :games
  has_and_belongs_to_many :sponsors

  scope :nickname, -> { find_by(nickname: ws[row, 3]) }
  scope :nickname_exist, -> { where(nickname: ws[row, 3]).exists? }  
end
