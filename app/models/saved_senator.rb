class SavedSenator < ApplicationRecord
  belongs_to :user
  belongs_to :senator
end
