class CuisineEvent < ApplicationRecord
  belongs_to :event
  belongs_to :cuisine
end
