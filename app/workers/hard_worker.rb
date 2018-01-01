class HardWorker
  include Sidekiq::Worker

  def perform(name, email, password)
    User.create(
      name: name,
      email: email,
      password: password,
      password_confirmation: password
    )
  end
end
