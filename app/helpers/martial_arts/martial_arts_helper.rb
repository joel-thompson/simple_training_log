module MartialArts::MartialArtsHelper
  def form_path
    @martial_art.id.present? ? martial_art_path(@martial_art) : martial_arts_path
  end

  def duration_and_location(martial_art)
    string = pluralize(martial_art.duration_in_minutes, "minute")
    string += " at " + martial_art.location if martial_art.location.present?
    string
  end
end
