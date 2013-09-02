require 'java'

require './lib/jrubyvaadin'
require './lib/rb-vaadin-events'
require './lib/dm-vaadin'

require 'data-model'
require 'data-init'

require 'demo-app-ui'

JRubyVaadin.start_app(ExampleApp)
