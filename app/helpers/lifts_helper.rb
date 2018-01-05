module LiftsHelper

  def sets_and_reps(lift)
    lift.weight.to_s + ' - ' +
    lift.sets.to_s + 'x' + lift.reps.to_s
  end

end
