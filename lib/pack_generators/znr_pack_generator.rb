require_relative '../card_constants'

module PackGenerators
  class ZnrPackGenerator
    def generate(_)
      selected = []
      required_uncommons = 3

      mdfc = cards_for(category: CardConstants::MDFC)
      selected.push(mdfc)

      if mdfc.rarity == CardConstants::UNCOMMON
        required_uncommons -= 1

        if Random.new.rand(8) == 7
          selected.push(cards_for(rarity: CardConstants::MYTHIC))
        else
          selected.push(cards_for(rarity: CardConstants::RARE))
        end
      end

      selected.push(*cards_for(rarity: CardConstants::UNCOMMON, count: required_uncommons))
      selected.push(*cards_for(rarity: CardConstants::COMMON, count: 10))
      selected.push(cards_for(category: CardConstants::BASIC_LAND))

      Pack.new(cards: selected)
    end

    private

    def cards_for(set: 'znr', category: CardConstants::NORMAL, rarity: nil, count: 1)
      cards = if rarity.nil?
        Card.where(set: set, category: category).shuffle.first(count)
      else
        Card.where(set: set, category: category, rarity: rarity).shuffle.first(count)
      end

      count == 1 ? cards.first : cards
    end
  end
end
