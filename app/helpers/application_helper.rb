module ApplicationHelper
  def menu_link_to(text, path)
    link_to_unless_current(text, path) { content_tag(:span, text) }
  end

  def disp_date(date)
    date.strftime("%y/%m/%d(#{%w(日 月 火 水 木 金 土)[date.wday]}) ") 
  end

  def disp_short_date(date)
    date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[date.wday]}) ") 
  end

  def page_image_tag(page, options = {})
    if page.image.present?
      path = page_path(page, format: page.image.extension)
      link_to(image_tag(path, { alt: page.date.to_s }.merge(options)), path)
    else
      ""
    end
  end
  def page_selfy_tag(page, options = {})
    if page.selfy.present?
      path = page_path(page, format: page.selfy.extension) + "&sefly=1"
      link_to(image_tag(path, { alt: page.date.to_s }.merge(options)), path)
    else
      ""
    end
  end
end
