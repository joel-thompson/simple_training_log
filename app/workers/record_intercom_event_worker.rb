class RecordIntercomEventWorker
  include Sidekiq::Worker

  def perform(user_id , event_name , metadata = {} , time = Time.now.to_i)

    max_retries = 3

    with_retries(:max_tries => max_retries, :rescue => [Intercom::RateLimitExceeded]) do |attempt|
      if attempt >= max_retries
        raise("No longer retrying since we have retried #{attempt} time.\n"\
          "The error returned was: '#{Intercom::RateLimitExceeded}'")
      end

      IntercomApi.events.create(
        event_name: event_name,
        created_at: time,
        user_id: user_id,
        metadata: metadata,
      )
    end

  end
end
