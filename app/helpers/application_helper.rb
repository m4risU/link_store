module ApplicationHelper

  def sortable(column, title = nil, remote = false)
    title ||= column.titleize

    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"

    if column == sort_column
      css_class = "current #{sort_direction}"
      direction_icon = direction == 'asc' ? 'glyphicon glyphicon-arrow-down' : 'glyphicon glyphicon-arrow-up'
    else
      css_class = nil
      direction_icon = 'glyphicon glyphicon-sort'
    end
    link_title = [
        title,
        ' ',
        content_tag(:span, '', class: "#{direction_icon}")
      ].join.html_safe

    link_to link_title, params.merge({:sort => column, :direction => direction}), {:class => css_class, remote: remote}
  end
end
