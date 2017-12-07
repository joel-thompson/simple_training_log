module Rounds
  class Create < Mutations::Command

    required do
      duck :martial_art
    end

    optional do
      string :partner_name, default: nil
      integer :submissions, default: 0
      duck :notes, default: nil #text
    end

    def validate
      # some kind of validation for the martial art should happen. do i care if the martial art is valid?
    end

    def execute
      round = Round.new(
        martial_art: martial_art,
        partner_name: partner_name,
        submissions: submissions,
        notes: notes
      )
      if round.save
        round
      else
        add_validation_errors(round.errors)
      end
    end

  end
end
