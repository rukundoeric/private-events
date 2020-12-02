class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :invites
  has_many :attendees, through: :invites, source: :user
end
