require 'database'
require 'ams_fixtures'

describe 'AmsFixtures' do
  describe '.fixtures_path' do
    it 'retrieves the configured fixtures_path' do
      AmsFixtures.configure(fixtures_path: '/foo/bar2')
      expect(AmsFixtures.fixtures_path).to eq('/foo/bar2')
    end
  end

  describe '.json_path' do
    it 'retrieves the configured fixtures_path' do
      AmsFixtures.configure(json_path: '/out/json')
      expect(AmsFixtures.json_path).to eq('/out/json')
    end
  end
end
