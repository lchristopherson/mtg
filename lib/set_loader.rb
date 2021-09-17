require 'net/http'

require_relative 'card_constants'

class SetLoader
  def load_set(set)
    uri = URI.parse("https://api.scryfall.com/cards/search?q=set%3A#{set}")

    puts "Hitting: https://api.scryfall.com/cards/search?q=set%3A#{set}"

    cards = []

    loop do
      # TODO: handle failed response
      response = Net::HTTP.get(uri)
      json = JSON.parse(response)

      cards += handle_cards(json['data'])

      break unless json['has_more']

      uri = URI.parse(json['next_page'])
    end

    cards
  end

  def load_list(cards)
    puts "Loading #{cards.count} cards"

    cards.map do |card|
      uri = URI.parse("https://api.scryfall.com/cards/named?exact=#{card}")

      response = Net::HTTP.get(uri)
      parsed = JSON.parse(response)

      if parsed['object'] != 'card'
        puts "Could not load card: #{card}"
        next
      end

      handle_cards([parsed])
    end.flatten
  end

  private

  def handle_cards(data)
    data.map do |card|
      {
          name: card['name'].downcase,
          set: card['set'].downcase,
          category: get_category(card),
          rarity: get_rarity(card),
          data: card
      }
    end
  end

  def get_category(data)
    if data['type_line'].include?('Basic Land')
      CardConstants::BASIC_LAND
    elsif data['layout'] == 'modal_dfc' || data['layout'] == 'transform'
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
    when 'special'
      CardConstants::SPECIAL
    when 'bonus'
      CardConstants::BONUS
    else
      raise "Unknown rarity: #{data['rarity']}"
    end
  end
end
