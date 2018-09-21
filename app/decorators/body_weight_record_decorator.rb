class BodyWeightRecordDecorator < ApplicationDecorator
  delegate_all

  def weighed_at_text
    h.time_ago_in_words(weighed_at).capitalize + " ago -"
  end

  def weight_text
    h.simple_format(weight.to_s)
  end

end
