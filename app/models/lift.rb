class Lift < ApplicationRecord
  after_initialize :inherit_default_sets_and_reps, :if => :new_record?

  belongs_to :lift_choice

  validates :lift_choice, presence: true
  validates :occurred_date, presence: true
  validates :occurred_time, presence: true

  validate :valid_occurred_time
  validate :has_weight_when_needed

  delegate :user, :has_weight, :has_weight?,
  :default_sets, :default_reps, :name, to: :lift_choice

  private def has_weight_when_needed
    errors.add(:weight, "should be empty") if self.weight.present? && !self.lift_choice&.has_weight?
    errors.add(:weight, "is required") if !self.weight.present? && self.lift_choice&.has_weight?
  end

  private def inherit_default_sets_and_reps
    inherit_default_sets
    inherit_default_reps
  end

  private def inherit_default_sets
    return if self.sets.present?
    self.sets = self.lift_choice.default_sets
  end

  private def inherit_default_reps
    return if self.reps.present?
    self.reps = self.lift_choice.default_reps
  end

end
