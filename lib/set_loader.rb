require 'net/http'

require_relative 'card_constants'

class SetLoader
  def load(set)
    uri = URI.parse("https://api.scryfall.com/cards/search?q=set%3A#{set}")

    puts "Hitting: https://api.scryfall.com/cards/search?q=set%3A#{set}"

    loop do
      # TODO: handle failed response
      response = Net::HTTP.get(uri)
      json = JSON.parse(response)

      handle_cards(json['data'])

      break unless json['has_more']

      uri = URI.parse(json['next_page'])
    end
  end

  private

  def handle_cards(data)
    card_data = data.map do |card|
      {
          set: card['set'],
          category: get_category(card),
          rarity: get_rarity(card),
          data: card
      }
    end

    Card.create(card_data)
  end

  def get_category(data)
    if data['type_line'].include?('Basic Land')
      CardConstants::BASIC_LAND
    elsif data['layout'] == 'modal_dfc'
      CardConstants::MDFC
    else
      CardConstants::NORMAL
    end
  end

  def get_rarity(data)
    case data['rarity']
    when 'mythic'
      CardConstants::MYTHIC
    when 'rare'
      CardConstants::RARE
    when 'uncommon'
      CardConstants::UNCOMMON
    when 'common'
      CardConstants::COMMON
    else
      raise "Unknown rarity: #{data['rarity']}"
    end
  end
end
