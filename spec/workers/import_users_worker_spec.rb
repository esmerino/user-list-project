require 'rails_helper'

RSpec.describe ImportUsersWorker do
  subject(:worker) { described_class.new }

  describe "#perform" do
    before do
      allow_any_instance_of(ImportUsersWorker).to receive(:users_list) do
        [
          {'id': 1, 'name': Faker::Name.name, 'age': rand(1..35), 'email': Faker::Internet.email}.transform_keys(&:to_s),
          {'id': 2, 'name': Faker::Name.name, 'age': rand(1..35), 'email': Faker::Internet.email}.transform_keys(&:to_s),
          {'id': 3, 'name': Faker::Name.name, 'age': rand(1..35), 'email': Faker::Internet.email}.transform_keys(&:to_s)
        ]
      end
    end

    it 'create users' do
      worker.perform

      expect(User.count).to eq(3)
    end
  end
end
