class TrainingProgramDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def name_text_formatted
    h.simple_format(name.capitalize)
  end

  def name_text
    name.capitalize
  end

  def notes_text
    h.simple_format(notes)
  end

end
