class Representative < ApplicationRecord
    belongs_to :state
    has_many :congressrepresentatives
    has_many :users, through: :congressrepresentatives
end
