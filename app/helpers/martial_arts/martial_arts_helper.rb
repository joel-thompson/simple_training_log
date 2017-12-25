module MartialArts::MartialArtsHelper
  def form_path
    @martial_art.id.present? ? martial_art_path(@martial_art) : martial_arts_path
  end

  def time_and_date_text
    return "" unless @martial_art.present?

    @martial_art.occurred_date.to_s(:short_ordinal) +
      " - " +
      @martial_art.occurred_time.capitalize
  end

  def duration_and_location
    string = pluralize(@martial_art.duration_in_minutes, "minute")
    string += " at " + @martial_art.location if @martial_art.location.present?
    string
  end
end
