module PackGenerators
  class DefaultPackGenerator
    def generate(set:)
      cards = Card.where(set: set)
      random = Random.new
      selected = []

      if random.rand(8) == 7 # add mythic
        selected.push(cards.where(rarity: 'mythic').shuffle.first)
      else
        selected.push(cards.where(rarity: 'rare').shuffle.first)
      end

      selected.push(*cards.where(rarity: 'uncommon').shuffle.first(3))
      selected.push(*cards.where(rarity: 'common').shuffle.first(11))

      # TODO add land

      Pack.new(cards: selected)
    end
  end
end
