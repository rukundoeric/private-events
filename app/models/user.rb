class User < ApplicationRecord
  has_many :events, inverse_of: :creator
  has_many :invites
end
