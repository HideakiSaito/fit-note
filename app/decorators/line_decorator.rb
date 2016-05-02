class LineDecorator < Draper::Decorator
  delegate_all
def self.collection_decorator_class
  PaginatingDecorator
end 
def short_label
#  '[' + no.to_s + '.' + part.name + ']'
  '[' + no.to_s + '.' + item.part.name + ']'
end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
# value="<%= '前へ[' + @prev_line.no.to_s + '.' + @prev_line.item.part.name + ']' %>"
end
