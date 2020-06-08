class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :cuisine
end
