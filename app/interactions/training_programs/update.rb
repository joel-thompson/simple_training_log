module TrainingPrograms
  class Update < ActiveInteraction::Base

    object :program, class: TrainingProgram
    string :name, default: nil, strip: true
    string :notes, default: nil, strip: true

    def to_model
      program
    end

    def execute
      update_program
    end

    private def update_program
      program.name = name if name?
      program.notes = notes if notes?

      unless program.save
        errors.merge!(program.errors)
      end

      program
    end
  end
end
