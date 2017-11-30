class Mutations::Command

  # takes in an ApplicationRecord object, adds the validation errors to the mutation errors
  def add_validation_errors(errors)
    return if !errors.present?
    errors.to_hash_array.each do |error|
      add_error(error[:key], error[:detail], error[:message])
    end
  end

end
