class CubeCard < ApplicationRecord
  self.table_name = 'cards_cubes'

  belongs_to :card
  belongs_to :cube
end
