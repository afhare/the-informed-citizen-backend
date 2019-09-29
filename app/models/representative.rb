class Representative < ApplicationRecord
    belongs_to :state
    has_many :house_committees
    has_many :joint_committees
    has_many :saved_representatives
    has_many :users, through: :saved_representatives
end
