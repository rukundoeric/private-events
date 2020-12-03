class User < ApplicationRecord
  has_many :events, inverse_of: :creator
  has_many :invites
  has_many :attended_events, through: :invites, source: :event

  validates :name, presence: true, length: { minimum: 3 }
end
