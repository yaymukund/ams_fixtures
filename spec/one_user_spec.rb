require 'database'
require 'ams_fixtures'

describe 'a fixture with one user' do
  let(:fixture) { AmsFixtures::Fixture.new('one_user_fixture') }

  before do
    fixture.make :user, name: 'Oscar',
                        gender: 'other',
                        status: 'single',
                        mood: 'pleased'
  end

  it 'adds the user to .records' do
    expect(fixture.records[:user]).to be_a(User)
  end

  describe 'the parsed JSON' do
    subject(:parsed_json) { JSON.parse(fixture.to_json) }

    it 'contains a user payload' do
      expect(parsed_json).to contain_exactly(
        ['user', an_instance_of(Hash)]
      )
    end

    it 'returns the correct user in the payload' do
      payload = parsed_json.first[1]

      expect(payload).to match({
        'user' => a_hash_including(
          'name' => 'Oscar',
          'gender' => 'other',
          'status' => 'single',
          'mood' => 'pleased'
        )
      })
    end
  end
end
