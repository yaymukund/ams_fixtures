# AmsFixtures

Use Fabrication and ActiveModelSerializers to generate fixtures for your
JavaScript tests.

## Usage

First, generate fixtures before your tests. In this example, they're in a Rake
task that gets run before each spec.

```ruby
namespace :test do
  desc 'Generate fixtures for JS tests.'
  task fixtures: :environment do
    require 'ams_fixtures'

    AmsFixtures.generate do
      fixture 'playlist_fixtures' do
        make :room
      end

      fixture 'playlist_with_tracks_fixtures' do
        make :room
        make_times 5, :track, room: records[:room]
      end
    end
  end
end
```

Then, in your tests, require the fixtures and use them:

```javascript
// This assumes you've already generated fixtures.
//= require ./assets/fixtures

var loadFixture = function(name) {
  var store = this.lookup('store'),
      payloads = this.fixtures[name];

  Ember.run(function() {
    payloads.forEach(function(payload) {
      store.pushPayload(payload[0], payload[1]);
    });
  });
};

describe('a playlist', function() {
  beforeEach(function() {
    App.reset();
    loadFixture('playlist_fixtures');
  });

  it('loads fixtures correctly', function() {
    expect(store.all('playlist').get('length')).to.be(1);
  });
});
```

## Installation

Add this line to your application's Gemfile:

    gem 'ams_fixtures'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ams_fixtures
