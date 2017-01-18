include JRubyVaadin::UiEvents
include JRubyVaadin
include JRubyVaadin::UI

class ExampleApp < Application 
  def init()
    main = Window.new 'Example Application'
    set_main_window  main

    dm_cont = DataMapper::DmContainer.new(Person.all)

    horizontal = HorizontalLayout.new

    table = Table.new
    table.container_data_source = dm_cont
    table.selectable = true
    table.immediate = true
    table.page_length = 7

    form = Form.new
    form.immediate = true

    horizontal.spacing = true
    horizontal.add_component table
    horizontal.add_component form

    main.add_component horizontal
    
    listener = PropertyValueChangeListener.new do |event|
       form.item_data_source = table.get_item(table.value)
       form.visible = (table.value != nil)
    end 

    table.add_listener listener

  end
end

