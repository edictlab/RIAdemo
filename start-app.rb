require 'java'

require './lib/jrubyvaadin'
require './lib/rb-vaadin-events'
require './lib/dm-vaadin'

require_relative 'data-model'
require_relative 'data-init'

require_relative 'demo-app-ui'

JRubyVaadin.start_app(ExampleApp)
