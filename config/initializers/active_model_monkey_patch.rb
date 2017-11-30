class ActiveModel::Errors

  def to_hash_array
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

  def add_mutation_errors(errors)
    return if !errors.present?
    errors.symbolic.each { |key, value| add(key, value) }
  end

end
