class Congressrepresentative < ApplicationRecord
  belongs_to :user
  belongs_to :representative
end
