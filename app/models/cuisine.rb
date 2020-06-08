class Cuisine < ApplicationRecord
  has_many :invitations
  has_one :cuisine_event
  has_one :event, through: :events
end
