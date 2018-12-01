module TrainingPrograms
  class Update < ActiveInteraction::Base

    object :program, class: TrainingProgram
    object :user, class: User
    string :name, default: nil, strip: true
    string :notes, default: nil, strip: true
    string :schedule, default: nil, strip: true

    validate :ensure_correct_user

    def to_model
      program
    end

    def execute
      update_program
    end

    private def update_program
      program.name = name if name?
      program.notes = notes if notes?
      program.schedule = schedule if schedule?

      unless program.save
        errors.merge!(program.errors)
      end

      program
    end

    private def ensure_correct_user
      unless program.user == user
        errors.add(:user, "does not own this program")
      end
    end
  end
end
