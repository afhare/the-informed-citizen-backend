class Senator < ApplicationRecord
  belongs_to :state
  has_many :senate_committees
  has_many :saved_senators
  has_many :users, through: :saved_senators
end
