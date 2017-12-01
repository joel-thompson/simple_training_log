module MartialArts

  MARTIAL_ARTS_FRIENDLY_TYPES = ["Jiu Jitsu", "Other"].freeze

  def self.get_type(friendly_type)
    return nil unless MARTIAL_ARTS_FRIENDLY_TYPES.include? friendly_type
    return nil if friendly_type == "Other"
    "MartialArts::" + friendly_type.gsub(/\s+/, "").classify
  end

  def self.available_friendly_types
    MARTIAL_ARTS_FRIENDLY_TYPES
  end

end
