class CleanupDraftJob < ApplicationJob
  queue_as :default

  def perform(draft_id)
    draft = Draft.find(draft_id)

    draft.drafters.each do |drafter|
      drafter.update(left: nil, right: nil)

      if drafter.is_a?(BotDrafter) && drafter.deck.present?
        drafter.deck.cards.each do |card|
          drafter.deck.cards.delete(card)
        end

        drafter.deck.delete
      end

      drafter.delete
    end
  end
end
