require 'rails_helper'
RSpec.describe HardWorker, type: :worker do

  # NOTE: example of how I can test workers

  it "adds a job to the queue" do
    HardWorker.perform_async('bob', 'bob@joel.com', '12341234')
    expect(HardWorker).to have_enqueued_sidekiq_job('bob', 'bob@joel.com', '12341234')
  end

  it "does what it's supposed to do" do
    expect{
      HardWorker.new.perform('bob', 'bob@joel.com', '12341234')
    }.to change{User.count}.by(1)
  end

end
