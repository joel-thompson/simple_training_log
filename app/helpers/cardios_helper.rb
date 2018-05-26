module CardiosHelper
  def duration(cardio)
    pluralize(cardio.duration_in_minutes, "minute")
  end
end
