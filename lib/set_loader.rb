require 'net/http'

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
          rarity: card['rarity'],
          data: card
      }
    end

    Card.create(card_data)
  end
end
