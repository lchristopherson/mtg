class DeckCard < ApplicationRecord
  self.table_name = 'cards_decks'

  belongs_to :deck
  belongs_to :card
end
