class Cuisine < ApplicationRecord
  has_many :invitations
  has_many :cuisine_events
  has_many :events, through: :cuisine_events
end
