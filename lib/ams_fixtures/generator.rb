require 'ams_fixtures/fixture'

module AmsFixtures::Generator
  def initialize(options)
    @fixtures = []

    @options = {
      namespace: options[:namespace] || 'FIXTURES',
      fixture_path: options[:fixture_path] ||
                    File.join('spec', 'javascripts', 'fixtures', 'fixtures.js')
    }
  end

  def write!
    path = File.join(Rails.root, @options[:fixture_path])

    File.open(path, 'w') do |f|
      f.write <<-JSDOC.strip_heredoc
        #{@options[:namespace]} = #{as_json.to_json};
      JSDOC
    end
  end

  def fixture(name, &block)
    fixture = AmsFixtures::Fixture.new(name)
    fixture.instance_eval(&block)
    @fixtures << fixture
  end

  def as_json
    generated_json = {}
    @fixtures.each do |fixture|
      generated_json[fixture.name] = fixture.as_json
    end
    generated_json
  end
end
