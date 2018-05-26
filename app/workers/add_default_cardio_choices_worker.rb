class AddDefaultCardioChoicesWorker
  include Sidekiq::Worker

  def perform(user_id)
    @user = User.find_by(id: user_id)
    return if @user.nil?

    add_default_cardio_choices
  end

  def add_default_cardio_choices
    @user.cardio_choices.create(
      name: 'Run'
    )
  end
end
