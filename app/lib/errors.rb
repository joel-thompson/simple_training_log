module Errors
  # not really used anymore as it's part of the activemodel::errors class now
  def self.activemodel_to_hash_array(errors)
    keys = errors.keys
    details = errors.details
    messages = errors.messages
    hash_array = []

    keys.each do |key|

      messages[key].zip(details[key]).each do |message, detail|
        hash = {}
        hash[:key] = key
        hash[:detail] = detail[:error]
        hash[:message] = message
        hash_array << hash
      end

    end

    hash_array
  end

end
