# Fixer lets you generate fixture files for JS tests using your server-side
# fabricators (fabricationgem.com) and ActiveModelSerializers. It's one
# implementation of Jo Liss's idea from this slideshare presentation:
#
#   http://www.slideshare.net/jo_liss/testing-ember-apps (Slide 50)
#
# Basically, by generating fixtures on the server, we can reuse all the
# FabricationGem/ActiveModel::Serializer code.
#
# Example usage:
#
# In bin/generate_fixtures.rb:
#
# require 'fixer'
#
# Fixer.define 'my_user_spec' do
#   make :user, login: 'yaymukund', password: 'nonsense'
#   make :payment, user: fixture[:user], amount: 300
# end
#
# In console, before tests:
#
# > bundle exec bin/generate_fixtures.rb
#
# This will produce:
#
# > cat spec/javascripts/fixtures/my_user_spec.js
#
# helper.fixtures = helper.fixtures || {};
# helper.fixtures['my_user_spec'] = [
#   ["user", {"user": {"id": 1, "login": "yaymukund", "password_hash": "938ywehwe@ef#FE"}}],
#   ["payment", {"payment": {"id": 1, "user_id": 1, "amount": 300}}]
# ]
#
# In your ember tests, you can load the fixture:
#
# App.reset(); // Wipe everything.
# helper.fixtures.my_user_spec.forEach(function(payload) {
#   lookup('store').pushPayload(payload[0], payload[1]);
# });
#
# And now you have the context for your tests!:
#
# expect(lookup('store').find('payment', '1'))
#
# TODO:
#   Generate JSON and generate a separate JS file that creates the
#   `helper.fixtures` scope and defines `loadFixtures`.
require 'fabrication'
require 'active_model_serializers'

class AmsFixtures::Fixture
  attr_reader :records, :name

  def initialize(name)
    @name = name
    @records = {}
    @payloads = []
  end

  def make(name, options={})
    record = Fabricate(name, options)
    @records[name.to_sym] = record

    resource = serialize_object(record)
    @payloads << [name.to_sym, resource]
  end

  def make_times(i, name, options={})
    records = Fabricate.times(i, name, options)
    plural_name = name.to_s.pluralize.to_sym
    @records[plural_name] = records

    resources = serialize_object(records)
    @payloads << [name, {name.to_s => resources}]
  end

  def write_to_file!
    namespace = AmsFixtures.fixtures_namespace

    File.open(File.join(AmsFixtures.fixtures_path, "#{@name}.js"), 'w') do |f|
      f.write <<-JSOUT.strip_heredoc
        #{namespace}.fixtures = #{namespace}.fixtures || {};
        #{namespace}.fixtures['#{@name}'] = #{to_json};
      JSOUT
    end
  end

  def as_json
    @payloads
  end

  private

  def serialize_object(object)
    serializer = ActiveModel::Serializer.serializer_for(object)
    serializer.new(object).as_json
  end
end
