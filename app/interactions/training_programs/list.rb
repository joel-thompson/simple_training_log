module TrainingPrograms
  class List < ActiveInteraction::Base
    object :user, class: User

    def execute
      list_programs
    end

    private def list_programs
      user.training_programs.order(activated_at: :desc)
    end
  end
end
