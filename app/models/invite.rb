class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: { invited: 0, accepted: 1 }
end
