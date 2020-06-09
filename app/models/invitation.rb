class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :cuisine
  # has_one :cuisine
  # problem here in belongs_to :cuisine
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
