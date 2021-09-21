module PackGenerators
  class DefaultPackGenerator
    def generate(set:)
      cards = Card.where(set: set)
      random = Random.new
      selected = []

      if random.rand(8) == 7 # add mythic
        selected.push(cards.where(rarity: CardConstants::MYTHIC).shuffle.first)
      else
        selected.push(cards.where(rarity: CardConstants::RARE).shuffle.first)
      end

      selected.push(*cards.where(rarity: CardConstants::UNCOMMON).shuffle.first(3))
      selected.push(*cards.where(rarity: CardConstants::COMMON).shuffle.first(10))

      # TODO add land

      Pack.new(cards: selected)
    end
  end
end
