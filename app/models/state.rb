class State < ApplicationRecord
    has_many :representatives
    has_many :senators
end
