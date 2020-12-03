class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def invite(event_id, user_id)
    Invite.find_by(event_id: event_id, user_id: user_id)
  end
end
