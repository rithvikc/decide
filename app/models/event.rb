class Event < ApplicationRecord
  has_many :invitations
  has_many :users, through: :invitations
  has_one :result
  has_one :restaurant, through: :results
  has_one :cuisine_event
  has_one :cuisine, through: :cuisine_events
end
