module TrainingPrograms
  class Deactivate < ActiveInteraction::Base
    object :program, class: TrainingProgram
    object :user, class: User
    time :at, default: nil

    validate :ensure_correct_user

    def execute
      deactivate_program
    end

    def deactivate_program
      program.deactivated_at = deactivated_at

      unless program.save
        errors.merge!(program.errors)
      end

      program
    end

    private def deactivated_at
      at || Time.now
    end

    private def ensure_correct_user
      unless program.user == user
        errors.add(:user, "does not own this program")
      end
    end
  end
end
