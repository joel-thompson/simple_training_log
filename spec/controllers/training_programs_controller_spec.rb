require 'rails_helper'

RSpec.describe TrainingProgramsController, type: :controller do

  fixtures :users, :training_programs

  let(:user) { users(:weight_lifter) }
  let(:program) { training_programs(:starting_strength) }

  context 'index' do
    it "lists the programs" do
      log_in_as user
      expect(TrainingPrograms::List).to receive(:run).with(user: user).and_call_original
      get :index
    end
  end

  context 'show' do
    it "finds the program" do
      log_in_as user
      expect(TrainingPrograms::Find).to receive(:run).with(user: user, id: program.id).and_call_original
      get :show, params: { id: program.id }
    end
  end

  context 'create' do
    it "attempts to create a program" do
      log_in_as user
      expect(TrainingPrograms::Create).to receive(:run).with(
        user: user,
        name: 'foo',
        notes: 'bar',
      ).and_call_original

      post :create, params: {
        training_program: {
          name: 'foo',
          notes: 'bar',
        }
      }
    end
  end

  context 'edit' do
    it "finds the program and preps it for the form" do
      log_in_as user
      expect(TrainingPrograms::Find).to receive(:run).with(user: user, id: program.id).and_call_original
      expect(TrainingPrograms::Update).to receive(:new).with(
        user: user,
        name: program.name,
        notes: program.notes,
        program: program,
      ).and_call_original
      get :edit, params: { id: program.id }
    end
  end

  context 'update' do
    it "updates a program" do
      log_in_as user

      expect(TrainingPrograms::Update).to receive(:run).with(
        user: user,
        name: 'updated foo',
        notes: 'updated bar',
        program: program,
      ).and_call_original

      put :update, params: {
        id: program.id,
        training_program: {
          name: 'updated foo',
          notes: 'updated bar',
        }
      }
    end
  end

  context 'destroy' do
    it "destroys the program" do
      log_in_as user
      expect(TrainingPrograms::Find).to receive(:run).with(user: user, id: program.id).and_call_original
      expect(TrainingPrograms::Destroy).to receive(:run).with(
        program: program,
        user: user,
      ).and_call_original

      delete :destroy, params: {
        id: program.id,
      }
    end
  end

  context 'deactivate' do
    it "deactivates the program sent" do
      log_in_as user
      expect(TrainingPrograms::Deactivate).to receive(:run).with(
        user: user,
        program: program,
      ).and_call_original
      put :deactivate, params: { id: program.id }
    end
  end

  context 'duplicate_and_activate' do
    it "creates a copy of the program" do
      log_in_as user
      expect(TrainingPrograms::DuplicateAndActivate).to receive(:run).with(
        user: user,
        program: program,
      ).and_call_original
      post :duplicate_and_activate, params: { id: program.id }
    end
  end

end
