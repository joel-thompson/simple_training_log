module Users
  class AddDefaultLiftChoices < Mutations::Command

    required do
      duck :user
    end

    # optional do
    #
    # end

    def execute

      user.lift_choices.create(
        name: 'Barbell Squat',
        has_weight: true,
        default_sets: 3,
        default_reps: 5
      )

      user.lift_choices.create(
        name: 'Barbell Deadlift',
        has_weight: true,
        default_sets: 1,
        default_reps: 5
      )

      user.lift_choices.create(
        name: 'Barbell Bench Press',
        has_weight: true,
        default_sets: 1,
        default_reps: 5
      )

    end

  end
end
