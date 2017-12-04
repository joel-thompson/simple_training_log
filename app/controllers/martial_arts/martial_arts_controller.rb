class MartialArts::MartialArtsController < ApplicationController
  def new
    @martial_art = MartialArts::MartialArt.new
  end

  
end
