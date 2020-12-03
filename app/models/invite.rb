class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: { invited: 0, accepted: 1 }

  validates :user_id, :event_id, presence: true
end
