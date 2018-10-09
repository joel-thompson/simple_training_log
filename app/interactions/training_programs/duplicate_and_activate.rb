module TrainingPrograms
  class DuplicateAndActivate < ActiveInteraction::Base
    object :program, class: TrainingProgram
    object :user, class: User

    time :at, default: nil

    validate :ensure_correct_user

    def execute
      create_copy_of_program
    end

    private def create_copy_of_program
      compose(
        TrainingPrograms::Create,
        user: user,
        name: program.name,
        notes: program.notes,
        at: activated_at,
      )
    end

    private def activated_at
      at || Time.now
    end

    private def ensure_correct_user
      unless program.user == user
        errors.add(:user, "does not own this program")
      end
    end
  end
end
