require 'java'

dir = File.dirname(File.expand_path(__FILE__)) 

Dir[dir + "/jars/vaadin/*.jar"].each { |jar|  require jar }
Dir[dir + "/jars/jetty7/*.jar"].each { |jar|  require jar }
puts "Finished loading jars."



module JRubyVaadin
  java_import 'com.vaadin.Application'
  java_import 'com.vaadin.terminal.gwt.server.AbstractApplicationServlet'
  module UI
    include_package 'com.vaadin.ui'
    %w[Window HorizontalLayout VerticalLayout Table Form Label Button].each do |name|
      java_import "com.vaadin.ui.#{name}"
    end
  end


  def self.start_app(app_class, port=8080, context_path="/")
    java_import 'org.eclipse.jetty.server.Server'
    java_import 'org.eclipse.jetty.servlet.ServletHolder'
    java_import 'org.eclipse.jetty.webapp.WebAppContext'
    server = Server.new(port)
    context = WebAppContext.new
    context.resource_base= "./"
    context.context_path = context_path 
    context.set_init_parameter('productionMode','true')
    context.add_servlet(ServletHolder.new(RbVaadinServlet.new(app_class)), "/*")

    server.handler = context
    server.start
    server.join
  end

  class RbVaadinServlet < AbstractApplicationServlet
    def initialize app_class
      super()
      @app_class = app_class
    end

    def getApplicationClass()
      return Application.java_class
    end
    def getNewApplication(request)
      @app_class.new
    end
  end

end


