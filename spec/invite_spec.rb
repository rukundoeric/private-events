require_relative 'rails_helper'

RSpec.describe Invite, type: :model do
  it 'validates presence of user_id and event_id' do
    event = Event.new(user_id: '')
    expect(event.valid?).to be(false)
  end

  context 'ActiveRecord associations' do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end
end
