class Event < ApplicationRecord
  has_many :invitations
  has_many :users, through: :invitations
  has_one :result
  has_one :restaurant, through: :results
  has_many :cuisine_events
  has_many :cuisines, through: :cuisine_events
  validates :name, :start_at, presence: true
  validates :hash_token, presence: true
  validates :hash_token, uniqueness: true

  before_validation :generate_hash_token

  def invited_users
    relation_a = User.where(last_event: id).to_a
    relation_b = users.to_a
    (relation_a + relation_b).uniq(&:id)
  end

  def users_pending_invitation
    User.where(last_event: id, invitation_accepted_at: nil)
  end

  def generate_hash_token
    begin
      self.hash_token = SecureRandom.urlsafe_base64(24, false)
    end while self.class.exists?(hash_token: hash_token)
  end

  def to_param
    token
  end
end
