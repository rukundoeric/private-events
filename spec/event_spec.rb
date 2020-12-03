require_relative 'rails_helper'

RSpec.describe Event, type: :model do
  it 'validates presence of name, description, location, date and creator' do
    event = Event.new(name: '', description: '', location: '')
    expect(event.valid?).to be(false)
  end

  context 'ActiveRecord associations' do
    it { should belong_to(:creator).class_name('User') }
    it { should have_many(:invites) }
    it { should have_many(:attendees).through(:invites) }
  end
end
