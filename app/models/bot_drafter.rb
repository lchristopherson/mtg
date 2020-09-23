class BotDrafter < Drafter
  def pick_card(pack)
    card = pack.cards.first

    handle_pick(pack, card.data['id'])
  end
end
