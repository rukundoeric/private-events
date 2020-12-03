require_relative 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates name, username and email' do
    user = User.new(name: '')
    expect(user.valid?).to be(false)
  end

  describe 'ActiveRecord associations' do
    it { should have_many(:events) }
    it { should have_many(:invites) }
    it { should have_many(:attended_events).through(:invites) }
  end
end
