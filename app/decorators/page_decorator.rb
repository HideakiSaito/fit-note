class PageDecorator < Draper::Decorator
  delegate_all
#def self.collection_decorator_class
#  PaginatingDecorator
#end
def date_jp
  date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})") 
end

# Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
