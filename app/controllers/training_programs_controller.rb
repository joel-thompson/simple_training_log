class TrainingProgramsController < ApplicationController
  before_action :logged_in_user

  def index
    @current_training_program = current_user&.active_training_program&.decorate
    outcome = TrainingPrograms::List.run(user: current_user)

    if outcome.valid?
      @training_programs = TrainingProgramDecorator.decorate_collection(outcome.result.paginate(page: params[:page]))
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
      redirect_to root_url
    end
  end

  def show
    @training_program = find_training_program.decorate
  end

  def new
    @training_program = TrainingPrograms::Create.new
  end

  def create
    outcome = TrainingPrograms::Create.run(
      user: current_user,
      name: params[:training_program][:name],
      notes: params[:training_program][:notes],
      schedule: params[:training_program][:schedule],
    )

    if outcome.valid?
      flash[:success] = "Training program created"
      redirect_to(outcome.result)
    else
      @training_program = outcome
      render 'new'
    end
  end

  def edit
    training_program = find_training_program
    @training_program = TrainingPrograms::Update.new(
      user: current_user,
      name: training_program.name,
      notes: training_program.notes,
      schedule: training_program.schedule,
      program: training_program,
    )
  end

  def update
    training_program = find_training_program
    outcome = TrainingPrograms::Update.run(
      user: current_user,
      name: params[:training_program][:name],
      notes: params[:training_program][:notes],
      schedule: params[:training_program][:schedule],
      program: training_program,
    )

    if outcome.valid?
      flash[:success] = "Training program updated"
      redirect_to(outcome.result.decorate)
    else
      @training_program = outcome
      render 'edit'
    end
  end

  def destroy
    training_program = find_training_program
    outcome = TrainingPrograms::Destroy.run(program: training_program, user: current_user)

    if outcome.valid?
      flash[:success] = "Training program deleted"
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
    end
    redirect_to training_programs_path
  end

  def deactivate
    training_program = find_training_program
    outcome = TrainingPrograms::Deactivate.run(program: training_program, user: current_user)

    if outcome.valid?
      flash[:success] = "Training program deactivated"
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
    end
    redirect_to training_programs_path
  end

  def duplicate_and_activate
    training_program = find_training_program
    outcome = TrainingPrograms::DuplicateAndActivate.run(program: training_program, user: current_user)

    if outcome.valid?
      flash[:success] = "Training program duplicated"
      redirect_to(outcome.result)
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
      redirect_to training_programs_path
    end
  end

  private def find_training_program
    outcome = TrainingPrograms::Find.run(user: current_user, id: params[:id].to_i)

    if outcome.valid?
      outcome.result
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
      redirect_to training_programs_path
    end
  end
end
