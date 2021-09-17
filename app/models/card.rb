class Card < ApplicationRecord
  include Comparable

  RARITY_ORDER = {
      CardConstants::MYTHIC => 0,
      CardConstants::SPECIAL => 1,
      CardConstants::BONUS => 2,
      CardConstants::RARE => 3,
      CardConstants::UNCOMMON => 4,
      CardConstants::COMMON => 5
  }

  CATEGORY_ORDER = {
      CardConstants::MDFC => 0,
      CardConstants::NORMAL => 1,
      CardConstants::BASIC_LAND => 2
  }

  def to_json
    case self.data['layout']
    when 'normal'
      parse_normal
    when 'modal_dfc', 'transform'
      parse_mdfc
    else
      puts "Parsing layout: #{self.data['layout']} as 'normal'"

      parse_normal
    end
  end

  def <=>(other)
    [RARITY_ORDER[self.rarity], CATEGORY_ORDER[self.category], self.data['name']] <=> [RARITY_ORDER[other.rarity], CATEGORY_ORDER[other.category], other.data['name']]
  end

  private

  def parse_normal
    {
        id: self.data['id'],
        type: 'normal',
        cmc: self.data['cmc'],
        image_uris: self.data['image_uris']
    }
  end

  def parse_mdfc
    {
        id: self.data['id'],
        type: 'mdfc',
        cmc: self.data['cmc'],
        image_uris: [
            self.data['card_faces'][0]['image_uris'],
            self.data['card_faces'][1]['image_uris']
        ]
    }
  end
end
