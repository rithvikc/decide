class Event < ApplicationRecord
  has_many :invitations
  has_many :users, through: :invitations
  has_one :result
  has_one :restaurant, through: :results
  has_many :cuisine_events
  has_many :cuisines, through: :cuisine_events

  validates :name, :start_at, presence: true

  def invited_users
    relation_a = User.where(last_event: id).to_a
    relation_b = users.to_a
    (relation_a + relation_b).uniq(&:id)
  end

  def users_pending_invitation
    User.where(last_event: id)
  end
end
