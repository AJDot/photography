module ApplicationHelper
  def active_class(link_path, active_class)
    current_page?(link_path) ? active_class : ''
  end

  def display_paragraphs(text, options = {}, escape = true, &block)
    paragraphs = text.split(/\r?\n+/)
    build = paragraphs.map do |p|
      content_tag :p, p, options, escape, &block
    end.join("\n")

    escape ? build : build.html_safe
  end
end
