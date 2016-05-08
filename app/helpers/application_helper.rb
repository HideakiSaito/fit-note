module ApplicationHelper
  def menu_link_to(text, path)
    link_to_unless_current(text, path) { content_tag(:span, text) }
  end

  def page_image_tag(page, options = {})
    if page.image.present?
      path = page_path(page, format: page.image.extension)
      link_to(image_tag(path, { alt: page.date.to_s }.merge(options)), path)
    else
      ""
    end
  end
end
