class Cube < ApplicationRecord
  has_many :cube_cards
  has_many :cards, through: :cube_cards

  def to_json
  end
end
