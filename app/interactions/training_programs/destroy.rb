module TrainingPrograms
  class Destroy < ActiveInteraction::Base
    object :program, class: TrainingProgram
    object :user, class: User

    validate :ensure_correct_user

    def execute
      deactivate_program
      destroy_program
    end

    private def deactivate_program
      compose(TrainingPrograms::Deactivate, program: program, user: user)
    end

    private def destroy_program
      program.destroy!
    end

    private def ensure_correct_user
      unless program.user == user
        errors.add(:user, "does not own this program")
      end
    end
  end
end
