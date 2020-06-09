class Restaurant < ApplicationRecord
  has_one :result, dependent: :destroy
  has_one :event, through: :results
end
