class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :cuisine
  # has_one :cuisine
  # problem here in belongs_to :cuisine
end
