# backfill

MartialArts::MartialArt.find_each { |ma| ma.update(occurred_date: Date.parse(ma.occurred_at.to_s)) }
MartialArts::MartialArt.find_each { |ma| ma.update(occurred_time: "morning") }
