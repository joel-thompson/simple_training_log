module ApplicationHelper
	  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Logging Progress"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def when_text(occurred_at)
    if occurred_at < DateTime.now
      time_ago_in_words(occurred_at) + " ago"
    else
      "In " + time_ago_in_words(occurred_at)
    end
  end

end
