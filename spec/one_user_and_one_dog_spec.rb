require 'database'
require 'ams_fixtures'

describe 'a fixture with one user and their dog' do
  let(:fixture) { AmsFixtures::Fixture.new('one_user_and_one_dog_fixture') }

  before do
    fixture.make :user, name: 'Oscar',
                        gender: 'other',
                        status: 'single',
                        mood: 'pleased'

    fixture.make :dog, name: 'Fido',
                       user: fixture.records[:user]
  end

  it 'adds the user and dog to .records' do
    expect(fixture.records).to include(
      user: an_instance_of(User),
      dog: an_instance_of(Dog)
    )
  end

  describe '.as_json' do
    subject(:payloads) { fixture.as_json }

    it 'contains a user payload and dog payload' do
      expect(payloads).to contain_exactly(
        [:user, an_instance_of(Hash)],
        [:dog, an_instance_of(Hash)]
      )
    end

    it 'returns the correct user payload' do
      payload = payloads.find { |p| p.first == :user }[1]

      expect(payload).to match({
        'user' => a_hash_including(
          name: 'Oscar',
          gender: 'other',
          status: 'single',
          mood: 'pleased'
        )
      })
    end

    it 'returns the correct dog payload' do
      payload = payloads.find { |p| p.first == :dog }[1]

      expect(payload).to match(
        'dog' => a_hash_including(
          name: 'Fido',
          user: an_instance_of(User)
        )
      )
    end
  end
end
