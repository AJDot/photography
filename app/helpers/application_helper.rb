module ApplicationHelper
  def active_class(link_path, active_class)
    current_page?(link_path) ? active_class : ''
  end
end
