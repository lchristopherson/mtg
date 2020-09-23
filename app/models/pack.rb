class Pack < ApplicationRecord
  class CardNotFound < Exception
    def initialize(mtg_id, pack_id)
      super("Card with id=#{mtg_id} not found in pack #{pack_id}")
    end
  end

  has_many :pack_cards
  has_many :cards, through: :pack_cards

  belongs_to :drafter, optional: true

  def get_card(mtg_id)
    card = self.cards.select { |card| card.data['id'] == mtg_id }.first

    raise CardNotFound.new(mtg_id, self.id) if card.nil?

    card
  end

  def matches(expected)
    expected['pack'] == self.number && expected['cards'] == self.cards.count
  end

  def empty?
    self.cards.empty?
  end

  def opposite_direction
    self.pass_direction == 'LEFT' ? 'RIGHT' : 'LEFT'
  end
end
