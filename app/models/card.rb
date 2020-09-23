class Card < ApplicationRecord
  include Comparable

  RARITY_ORDER = {
      mythic: 0,
      rare: 1,
      uncommon: 2,
      common: 3
  }

  def to_json
    {
        id: self.data['id'],
        image_uris: self.data['image_uris']
    }
  end

  def <=>(other)
    [RARITY_ORDER[self.rarity.to_sym], self.data['name']] <=> [RARITY_ORDER[other.rarity.to_sym], other.data['name']]
  end
end
