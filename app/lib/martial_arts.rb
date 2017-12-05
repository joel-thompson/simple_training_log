module MartialArts



  MARTIAL_ARTS_FRIENDLY_TYPES = ["Jiu Jitsu", "Other"].freeze
  MARTIAL_ARTS_TYPES = ["MartialArts::JiuJitsu", "MartialArts::MartialArt"]

  def self.get_type(friendly_type)
    return nil unless MARTIAL_ARTS_FRIENDLY_TYPES.include? friendly_type
    return nil if friendly_type == "Other"
    "MartialArts::" + friendly_type.gsub(/\s+/, "").classify
  end

  def self.available_friendly_types
    MARTIAL_ARTS_FRIENDLY_TYPES
  end

  def self.use_relative_model_naming?
    true
  end

  def self.available_types
    MARTIAL_ARTS_TYPES
  end

  def self.choices
    array = []
    MARTIAL_ARTS_FRIENDLY_TYPES.zip(MARTIAL_ARTS_TYPES).each do |a, b|
      array << [a,b]
    end

  end

end
