require_relative '../card_constants'

module PackGenerators
  class KhmPackGenerator
    SNOW_LAND_IDS = [
        # Dual lands
        273, 278, 384, 407, 412, 484, 520, 531, 565, 574,

        # Basic lands
        515, 515, 516, 516, 517, 517, 518, 518, 519, 519
    ].freeze

    def generate(_)
      prng = Random.new
      selected = []

      if Random.new.rand(8) == 7
        selected.push(cards_for(rarity: CardConstants::MYTHIC))
      else
        selected.push(cards_for(rarity: CardConstants::RARE))
      end

      selected.push(*cards_for(rarity: CardConstants::UNCOMMON, count: 3))
      selected.push(*cards_for(rarity: CardConstants::COMMON, count: 10))
      selected.push(Card.find(SNOW_LAND_IDS[prng.rand(SNOW_LAND_IDS.count)]))

      Pack.new(cards: selected)
    end

    private

    def cards_for(set: 'khm', category: CardConstants::NORMAL, rarity: nil, count: 1)
      cards = if rarity.nil?
        Card.where(set: set, category: category).shuffle.first(count)
      else
        Card.where(set: set, category: category, rarity: rarity).shuffle.first(count)
      end

      count == 1 ? cards.first : cards
    end
  end
end
