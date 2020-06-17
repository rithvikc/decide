class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :cuisine
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  def cancelled?
    status == "Cancelled"
  end
end
