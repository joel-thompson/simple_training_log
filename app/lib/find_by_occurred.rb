module FindByOccurred

  # this module gives the class the ability to find records by occurred easily


# TODO this is not properly tested right now
  def last_occurred
    most_recent_date = self.order({ occurred_date: :asc }).last.occurred_date
    options = self.where(occurred_date: most_recent_date).to_a.flatten
    Entries.sort_by_occurred!(options).first
  end
end
