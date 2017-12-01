module MartialArts
  class Create < Mutations::Command

    required do
      string :friendly_type
    end

    optional do
      duck :occurred_at, methods: [:acts_like_time?], default: Time.zone.now
      duck :notes, default: nil
    end

    def validate
      add_error(:friendly_type, :invalid, "is not a valid type") unless valid_friendly_type?
    end

    def execute
      martial_art = MartialArts::MartialArt.new(
        type: MartialArts.get_type(friendly_type),
        occurred_at: occurred_at,
        notes: notes
      )
      if martial_art.save
        martial_art
      else
        add_validation_errors(martial_art.errors)
      end
    end

    def valid_friendly_type?
      MartialArts.available_friendly_types.include? friendly_type
    end

  end
end
