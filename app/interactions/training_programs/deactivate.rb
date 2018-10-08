module TrainingPrograms
  class Deactivate < ActiveInteraction::Base
    object :program, class: TrainingProgram
    time :at, default: nil

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
  end
end
