// Given a fixture name and an Ember store, load the fixtures.
var loadFixtures = function(name, store) {
  var payloads = FIXTURES[name];

  Ember.run(function() {
    payloads.forEach(function(payload) {
      store.pushPayload(payload[0], payload[1]);
    });
  });
};
