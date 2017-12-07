module MartialArts::MartialArtsHelper
  def form_path
    @martial_art.id.present? ? martial_art_path(@martial_art) : martial_arts_path
  end
end
