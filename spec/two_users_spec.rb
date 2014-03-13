require 'database'
require 'ams_fixtures'

describe 'a fixture with two users' do
  let(:fixture) { AmsFixtures::Fixture.new('user_fixture') }

  before do
    fixture.make_times 2, :user, gender: 'other',
                                 status: 'open',
                                 mood: 'grumpy'
  end

  it 'adds the users to .records' do
    expect(fixture.records[:users]).to contain_exactly(
      an_instance_of(User), an_instance_of(User)
    )
  end

  describe 'the parsed JSON' do
    subject(:parsed_json) { JSON.parse(fixture.to_json) }

    it 'contains a single payload' do
      expect(parsed_json.length).to eq(1)
    end

    it 'returns the correct users in the payload' do
      payload = parsed_json.first
      expect(payload).to match(['user', {
        'user' => [
          a_hash_including(
            'gender' => 'other',
            'status' => 'open',
            'mood' => 'grumpy'
          ),

          a_hash_including(
            'gender' => 'other',
            'status' => 'open',
            'mood' => 'grumpy'
          )
        ]
      }])
    end
  end
end
