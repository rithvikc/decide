class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :cuisine
  geocoded_by :location
  before_create :generate_token
  after_validation :geocode, if: :will_save_change_to_location?
  validates :location, :cuisine_id, presence: true

  def cancelled?
    status == "Declined"
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

end
