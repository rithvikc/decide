class Event < ApplicationRecord
  has_many :invitations
  has_many :users, through: :invitations
  has_one :result
  has_one :restaurant, through: :results
  has_many :cuisine_events
  has_many :cuisines, through: :cuisine_events

  validates :name, :start_at, presence: true
end
