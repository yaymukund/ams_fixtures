require 'database'
require 'ams_fixtures'

describe 'Fixture' do
  it 'defines `make` and `make_times`' do
    fixture = AmsFixtures::Fixture.new('fixture')
    expect(fixture.methods).to include(:make, :make_times)
  end
end
