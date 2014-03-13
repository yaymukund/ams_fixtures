require "ams_fixtures/version"
require 'ams_fixtures/fixture'

module AmsFixtures
  @configuration = {}

  def self.configure(options)
    @configuration.merge!(options)
  end

  def self.fixtures_path
    @configuration[:fixtures_path]
  end

  def self.json_path
    @configuration[:json_path]
  end
end
