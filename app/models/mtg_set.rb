class MtgSet < ApplicationRecord
  self.table_name = 'sets'

  COLOR_MAP = {
      "W" => 0,
      "U" => 1,
      "B" => 2,
      "R" => 3,
      "G" => 4
  }

  def to_json
    Card.where(set: self.code.downcase)
        .sort { |a, b| to_sort_values(a) <=> to_sort_values(b) }
        .map(&:to_json)
  end

  private

  def to_sort_values(card)
    data = card.data

    sorted_colors = if card.category == CardConstants::MDFC
                      data['card_faces'][0]['colors']
                    else
                      data['colors']
                    end.sort { |a, b| COLOR_MAP[a] <=> COLOR_MAP[b] }

    joined = sorted_colors.map { |c| COLOR_MAP[c] }.join

    # Put artifacts last :)
    prio = joined.length == 0 ? 10 : joined.length

    [prio, joined, data['name']]
  end
end
