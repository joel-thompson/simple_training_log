module TrainingPrograms
  class Find < ActiveInteraction::Base
    integer :id
    object :user

    def execute
      user.training_programs.find_by(id: id)
    end
  end
end
