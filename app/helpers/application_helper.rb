module ApplicationHelper
  # Wraps `content` in a calendar icon.
  def calendarize(content)
    tag.span(icon('far', 'calendar', class: 'fa-6x') + content,
             class: ['fa-calendar-wrapper'])
  end
end
