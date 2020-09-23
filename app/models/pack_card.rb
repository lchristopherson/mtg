class PackCard < ApplicationRecord
  self.table_name = 'cards_packs'

  belongs_to :pack
  belongs_to :card
end
