module TrainingPrograms
  class Destroy < ActiveInteraction::Base
    object :program, class: TrainingProgram

    def execute
      deactivate_program
      destroy_program
    end

    private def deactivate_program
      compose(TrainingPrograms::Deactivate, program: program)
    end

    private def destroy_program
      program.destroy!
    end
  end
end
