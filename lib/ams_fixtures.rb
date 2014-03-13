require 'ams_fixtures/version'
require 'ams_fixtures/fixture'
require 'ams_fixtures/generator'
require 'ams_fixtures/engine'

module AmsFixtures
  def self.generate(options={}, &block)
   generator = Generator.new(options)

   ActiveRecord::Base.transaction do
     generator.instance_eval(&block)
   end

   generator.write!
  end
end
