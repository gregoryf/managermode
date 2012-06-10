module ApplicationHelper
  
  def link_to_icon(icon, text)
    link = content_tag('i', "", class: "icon-#{icon}") + " #{text}"
  end
end
