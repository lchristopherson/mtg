class Deck < ApplicationRecord
  has_one :drafter

  has_many :deck_cards
  has_many :cards, through: :deck_cards

  def to_json
    {
        id: self.id,
        cards: self.cards.map(&:to_json)
    }
  end

  def to_text
    hash = Hash.new { |h, k| h[k] = 0 }
    self.cards.map do |card|
      card.data['name']
    end.each_with_object(hash) do |name|
      hash[name] += 1
    end.map do |name, count|
      "#{count} #{name}"
    end.join("\n")
  end
end
