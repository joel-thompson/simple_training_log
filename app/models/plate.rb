class Plate
  include ActiveModel::Validations

  attr_reader :weight

  PLATE_CHOICES = [45.0, 35.0, 25.0, 10.0, 5.0, 2.5].freeze
  DEFAULT_PLATE_WEIGHT = 45.0.freeze

  validates :weight, presence: true
  validate :valid_weight

  def self.choices
    PLATE_CHOICES
  end

  def initialize(weight: DEFAULT_PLATE_WEIGHT)
    update_weight(weight)
  end

  def weight=(weight)
    update_weight(weight)
  end

  private def update_weight(weight)
    @weight = weight.to_f
    self.errors.clear
  end

  private def valid_weight
    errors.add(:weight, "must be one of #{PLATE_CHOICES.to_s}") unless PLATE_CHOICES.include? @weight
  end
end
