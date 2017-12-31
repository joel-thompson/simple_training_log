module LiftChoicesHelper

  def has_weight_text(lift_choice)
    if lift_choice.has_weight?
      "Uses Weight"
    else
      "Bodyweight"
    end
  end

  def default_reps_text(lift_choice)
    if lift_choice.default_reps.present?
      "Default Reps: " + lift_choice.default_reps.to_s
    else
      "Default Reps: N/A"
    end
  end

  def default_sets_text(lift_choice)
    if lift_choice.default_sets.present?
      "Default Sets: " + lift_choice.default_sets.to_s
    else
      "Default Sets: N/A"
    end
  end

end
