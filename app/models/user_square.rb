class UserSquare < ApplicationRecord
  belongs_to :user
  belongs_to :square
end
