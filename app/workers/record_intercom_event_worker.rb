class RecordIntercomEventWorker
  include Sidekiq::Worker

  def perform(user_id , event_name , metadata , time = Time.now.to_i)
    IntercomApi.events.create(
      event_name: event_name,
      created_at: time,
      user_id: user_id,
      metadata: metadata,
    )
  end
end
