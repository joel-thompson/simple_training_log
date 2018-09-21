class UserDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def thirty_day_weight_graph
    series = (Date.today - 1.month)..(Date.today)
    series.map do |date|
      weight = if date == Date.today
        active_body_weight_record(Time.now)&.weight
      else
        active_body_weight_record(date)&.weight
      end
      next unless weight
      [date, weight]
    end.compact
  end

  def has_weight_records?
    user.body_weight_records.any?
  end

end
