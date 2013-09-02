# JRubyVaadin: DataMapper adaptation for Vaadin Java RIA framework
require 'dm-core'
require 'dm-validations'
require 'dm-types'



module DataMapper

  module VaadinData
    include_package 'com.vaadin.data'
  end

  module VaadinEvents
    java_import 'java.util.EventObject'

    class RbItemSetChangeEvent < EventObject
      include VaadinData::Container::ItemSetChangeEvent
      def getContainer
        return getSource 
      end
    end

    class RbValueChangeEvent < EventObject
      include VaadinData::Property::ValueChangeEvent
      def getProperty
        return getSource 
      end
    end
  end # of module VaadinEvents

  $MAPPINGS=
    { 
    DataMapper::Property::Float => java.lang.Float.java_class,
    DataMapper::Property::Integer => java.lang.Long.java_class,
    DataMapper::Property::String => java.lang.String.java_class,
    DataMapper::Property::Text => java.lang.String.java_class,
    DataMapper::Property::Decimal => java.lang.Double.java_class,
    DataMapper::Property::Boolean => java.lang.Boolean.java_class,
    DataMapper::Property::Serial => java.lang.Long.java_class
  }

  class DmContainer
    include com.vaadin.data.Container
    include com.vaadin.data.Container::ItemSetChangeNotifier

    def initialize dm_cont, query={}
      @orig= dm_cont
      @query = query
      reload 
    end

    def reload
      @dm_cont = @orig.reload @query
      notify_item_listeners
    end

    def new_item item
      item.add_item_change_listener self
      item
    end

    def addListener(listener)
      @item_listeners||=[]
      @item_listeners << listener
    end

    def item_changed item, prop
      notify_item_listeners 
    end
    def removeListener(listener)
      @item_listeners||=[]
      @item_listeners.delete listener
    end

    def notify_item_listeners 
      if @item_listeners
        event = VaadinEvents::RbItemSetChangeEvent.new(self)
        @item_listeners.each do |listener|
          listener.containerItemSetChange(event)  # { event }
        end
      end
    end

    def notify_old item, prop
      if @item_listeners
        event = VaadinEvents::RbValueChangeEvent.new(prop)
        @item_listeners.each do |listener|
          listener.valueChange event # { event }
        end
      end
    end

    def apply_filter filter
      @dm_cont= @orig.all(filter)
      notify_item_listeners
    end

    def getItem id
      @dm_cont.get(id)
    end

    def getContainerPropertyIds
      @dm_cont.properties.map { |prop| prop.name.to_s }
    end

    def getItemIds
      @dm_cont.map { |item| item.id }
    end

    def getContainerProperty(item_id, prop)
      @dm_cont.get(item_id).getItemProperty(prop)
    end

    def getType prop 
      return $MAPPINGS[@dm_cont.properties[prop].class]
    end

    def nextItemId id
      raise java.lang.UnsupportedOperationException.new("Not implemented")
    end

    def size
      @dm_cont.count
    end
    def containsId id
      @dm_cont.get(id) != nil
    end

    def addItem *id
      raise java.lang.UnsupportedOperationException.new("Not implemented.")
    end

    def removeItem id
      item = @dm_cont.get(id)
      if !item or !id
        return false
      end
      retval = item.destroy
      if retval
       @dm_cont.delete(item)
       @dm_cont.save
       notify_item_listeners
      end
      retval
    end

    def addContainerProperty(id,type,val)
      raise java.lang.UnsupportedOperationException.new("Not implemented.")
    end
    def removeContainerProperty id
      raise java.lang.UnsupportedOperationException.new("Not implemented.")
    end

    def removeAllItems
      retval = @dm_cont.destroy
      notify_item_listeners
      retval
    end

    def respond_to?(sym)
      @dm_cont.respond_to?(sym) || super(sym)
    end

    def method_missing(sym, *args, &block)
      return @dm_cont.send(sym, *args, &block) if @dm_cont.respond_to?(sym)
      super(sym, *args, &block)
    end
  end  # end of DmContainer

  class DmProperty
    include com.vaadin.data.Property
    include com.vaadin.data.Property::ValueChangeNotifier
    @@prop_count = 0

    def initialize(element,field)
      @@prop_count += 1
      element.vaadin_properties

      @element = element
      @field = field
      @listeners = []
    end

    def addListener obj
      @listeners << obj
    end

    def removeListener obj
      @listeners.delete obj
    end

    def getType
      return $MAPPINGS[@element.class.properties[@field].class]
    end

    def setValue(val)
      val=nil if val==""
      @element.send(@field+"=",val)
      fire_value_change if @element.vaadin_save self 
    end

    def isReadOnly
      return true if @element.class.properties[@field].class == DataMapper::Property::Serial
      false
    end

    def getValue
      @element.send(@field)
    end

    def toString
      to_s
    end

    def to_s
      @element.send(@field).to_s
    end

    private
    def fire_value_change
      event = VaadinEvents::RbValueChangeEvent.new self
      @listeners.each {|c| c.valueChange event}
    end

  end # of class DmProperty

  # DataMapper::Resource adaptation for Vaadin data model
  module Resource
    include com.vaadin.data.Item

    def add_item_change_listener(cont)
      @listener = cont 
    end

    def vaadin_save prop
      prev_id = self.id
      status= self.save
      if status
        if prev_id != self.id
          @listener.reload
        else
          #@listener.item_changed self, prop
        end
      end
      status
    end
    def addItemProperty(id,prop)
      raise java.lang.UnsupportedOperationException.new("Not supported")
    end
    def removeItemProperty(id)
      raise java.lang.UnsupportedOperationException.new("Not supported")
    end
    def getItemPropertyIds
      props= self.class.properties.reject { |t| t.key? || (t.index.class == Symbol ) }
      retval = props.map { |prop| prop.name.to_s }
      retval
    end
    def getItemProperty field 
      @vaadin_properties ||= {} 
      prop = @vaadin_properties[field]
      if !prop
        prop = DmProperty.new(self,field) if !prop
        @vaadin_properties[field] = prop
      end
      prop
    end

    def vaadin_properties
      @vaadin_properties
    end

  end # of module Resource

end # of module DataMapper
