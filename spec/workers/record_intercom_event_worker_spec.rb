require 'rails_helper'

RSpec.describe RecordIntercomEventWorker, type: :worker do

  fixtures :users

  let(:user) { users(:michael) }
  let(:other_user) { users(:joel) }

  it "adds a job to the queue" do
    RecordIntercomEventWorker.perform_async(user.id, 'Went to the movie', {foo: 'foo'})
    expect(RecordIntercomEventWorker).to have_enqueued_sidekiq_job(user.id, 'Went to the movie', {foo: 'foo'})
  end

  it "makes and Intercom api call to events" do
    time = Time.now.to_i
    expect(IntercomApi).to receive_message_chain(:events, :create).with(
      event_name: 'Went to the movie',
      created_at: time,
      user_id: user.id,
      metadata: {foo: 'foo'},
    )
    RecordIntercomEventWorker.new.perform(user.id, 'Went to the movie', {foo: 'foo'}, time)
  end

end
