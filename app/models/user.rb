class User < ApplicationRecord
    has_secure_password

    validates :name, :username, :user_state, :zipcode, presence: true
    validates :username, uniqueness: true

    belongs_to :state
    has_many :senators, through: :state
    has_many :congressrepresentatives
    has_many :representatives, through: :congressrepresentatives
end
