module MartialArts
  class Create < Mutations::Command

    required do
      string :type
      duck :user
    end

    optional do
      duck :occurred_at, methods: [:acts_like_time?], default: Time.zone.now
      duck :notes, default: nil
    end

    def validate
      add_error(:type, :invalid, "is not a valid type") unless valid_type?
    end

    def execute
      martial_art = MartialArts::MartialArt.new(
        user: user,
        type: type,
        occurred_at: occurred_at,
        notes: notes
      )
      if martial_art.save
        martial_art
      else
        add_validation_errors(martial_art.errors)
      end
    end

    def valid_type?
      MartialArts.available_types.include? type
    end

  end
end
