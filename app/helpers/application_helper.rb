module ApplicationHelper
	  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "LP"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def time_and_date_text(thing)
    return "" unless thing.present?

    thing.occurred_date.to_s(:short_ordinal) +
      " - " +
      thing.occurred_time.capitalize
  end

  def help_center_url
    "http://help.loggingprogress.com/" if Rails.env.production?
    "https://intercom.help/logging-progress-test"
  end

end
