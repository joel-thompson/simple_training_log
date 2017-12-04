module Techniques
  class Create < Mutations::Command

    required do
      string :name
      duck :martial_art
    end

    optional do
      duck :details, default: nil
      duck :notes, default: nil
    end

    def validate
      #code
    end

    def execute

      technique = Technique.new(
        martial_art: martial_art,
        name: name,
        details: details,
        notes: notes
      )

      if technique.save
        technique
      else
        add_validation_errors(technique.errors)
      end
    end

  end
end
