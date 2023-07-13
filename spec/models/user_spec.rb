require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.create' do
    context 'when user is created' do
      it 'responds true' do
        user = create(:user)

        expect(user).to be_valid
      end
    end
  end
end
