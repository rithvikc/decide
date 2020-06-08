class Restaurant < ApplicationRecord
  belongs_to :results, dependent: :destroy
  has_one :event, through: :results
end
