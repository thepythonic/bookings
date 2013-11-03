module Bookings
  class Engine < ::Rails::Engine
    isolate_namespace Bookings

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
      g.integration_tool :rspec
    	g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
  end
end
