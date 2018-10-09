module TrainingPrograms
  class Create < ActiveInteraction::Base

    object :user, class: User
    string :name, strip: true
    string :notes, strip: true
    time :at, default: nil

    def to_model
      TrainingProgram.new
    end

    def execute
      expire_previous_program if user.active_training_program
      create_program
    end

    private def expire_previous_program
      compose(TrainingPrograms::Deactivate,
        program: user.active_training_program,
        user: user,
        at: activated_at,
      )
    end

    private def create_program
      program = user.training_programs.new(
        name: name,
        notes: notes,
        activated_at: activated_at,
      )

      unless program.save
        errors.merge!(program.errors)
      end

      program
    end

    private def activated_at
      at || Time.now
    end
  end
end
