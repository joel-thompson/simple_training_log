class HardWorker
  include Sidekiq::Worker

  # NOTE: just an example worker
  # created with -- rails g sidekiq:worker Hard --

  def perform(name, email, password)
    User.create(
      name: name,
      email: email,
      password: password,
      password_confirmation: password
    )
  end
end
