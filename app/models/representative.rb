class Representative < ApplicationRecord
    belongs_to :state
    has_many :congressrepresentatives
    has_many :users, through: :congressrepresentatives
    has_many :house_committees
    has_many :joint_committees
end
