class HardWorker
  include Sidekiq::Worker

  def perform(name, email)
    User.create(
      name: name,
      email: email,
      password: '12341234',
      password_confirmation: '12341234'
    )
  end
end
