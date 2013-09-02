module JRubyVaadin
  module UiEvents

    class ButtonClickListener
      def self.new
          include JRubyVaadin::UI::Button::ClickListener
          super
      end
      def initialize &block
        self.define_singleton_method(:buttonClick, block) if block_given?
      end
    end

    class PropertyValueChangeListener
      include  Java::ComVaadinData::Property::ValueChangeListener
      def initialize &block
        self.define_singleton_method(:valueChange, block) if block_given?
      end
    end

    class EventListenerFactory
      def self.create listener_class, method_name, &block
        if block_given?
          listener = listener_class.new
          listener.define_singleton_method(method_name, block)
          listener
        end
      end
    end
  end


end
