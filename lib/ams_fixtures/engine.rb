require 'rails'
module AmsFixtures::Rails
  class Engine < ::Rails::Engine
    isolate_namespace AmsFixtures
    # We create an engine so Rails knows to include lib/assets in the
    # asset pipeline.
  end
end
