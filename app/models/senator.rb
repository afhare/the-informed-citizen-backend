class Senator < ApplicationRecord
  belongs_to :state
  has_many :senate_committees
end
