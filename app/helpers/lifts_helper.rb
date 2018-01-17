module LiftsHelper

  def sets_and_reps(lift)
    string = lift.weight.to_s + ' - ' +
             lift.sets.to_s + 'x' + lift.reps.to_s
    if lift.last_amrap_set.present?
      string += '+' + lift.last_amrap_set.to_s
    end
    string
  end

end
