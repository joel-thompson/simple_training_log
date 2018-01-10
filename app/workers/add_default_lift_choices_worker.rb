class AddDefaultLiftChoicesWorker
  include Sidekiq::Worker

  def perform(user_id)
    @user = User.find_by(id: user_id)
    return if @user.nil?

    add_default_lifts
  end

  def add_default_lifts
    @user.lift_choices.create(
      name: 'Barbell Squat',
      has_weight: true,
      default_sets: 3,
      default_reps: 5
    )

    @user.lift_choices.create(
      name: 'Barbell Deadlift',
      has_weight: true,
      default_sets: 1,
      default_reps: 5
    )

    @user.lift_choices.create(
      name: 'Barbell Bench Press',
      has_weight: true,
      default_sets: 3,
      default_reps: 5
    )
  end
end
