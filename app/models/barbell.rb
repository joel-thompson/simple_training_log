class Barbell
  include ActiveModel::Validations

  attr_reader :weight, :plates

  BARBELL_WEIGHT = 45.0.freeze

  validates :weight, presence: true, numericality: { greater_than_or_equal_to: BARBELL_WEIGHT }
  validate :valid_weight


  def initialize(weight: BARBELL_WEIGHT)
    update_weight(weight)
  end

  def weight=(weight)
    update_weight(weight)
  end

  def plate_count(weight)
    return nil unless Plate.choices.include? weight
    plates = @plates.select { |plate| plate.weight == weight.to_f}
    plates.count
  end

  private def update_weight(weight)
    @weight = weight.to_f
    @plates = []
    plates_per_side
    self.errors.clear
  end

  private def plates_per_side
    remaining_weight_per_side = (@weight - BARBELL_WEIGHT) / 2

    plate_choices = Plate.choices.sort_by{|pc| pc }.reverse
    plate_choices.each do |pc|
      count = remaining_weight_per_side >= pc ? (remaining_weight_per_side / pc).floor :  0
      @plates << count.times.collect { Plate.new(weight: pc) } if count > 0
      remaining_weight_per_side -= pc * count
    end

    @plates.flatten!
  end


  private def valid_weight
    smallest_choice = Plate.choices.min
    errors.add(:weight, "must be divisible by #{smallest_choice}") if (@weight % smallest_choice) != 0
  end

  private def trim_num(num)
    i, f = num.to_i, num.to_f
    i == f ? i : f
  end

end
