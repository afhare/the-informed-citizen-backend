class User < ApplicationRecord
    has_secure_password

    validates :name, :username, :user_state, presence: true
    validates :username, uniqueness: true

    belongs_to :state
    has_many :saved_senators
    has_many :senators, through: :saved_senators
    has_many :saved_representatives
    has_many :representatives, through: :saved_representatives
end
