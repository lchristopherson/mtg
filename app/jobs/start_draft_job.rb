class StartDraftJob < ApplicationJob
  queue_as :default

  TOTAL_DRAFTERS = 8

  def perform(draft_id)
    draft = Draft.find(draft_id)

    # Lock draft (set state)
    draft.update!(state: 'DRAFT')

    # Add bots if necessary
    human_count = draft.drafters.count

    puts "Adding #{TOTAL_DRAFTERS - human_count} bots"

    (TOTAL_DRAFTERS - human_count).times do |i|
      BotDrafter.create(user: "bot", draft: draft, name: "Bot #{i + 1}")
    end

    # Configure adjacencies
    shuffled = draft.drafters.to_a.shuffle

    shuffled.each_with_index do |d, i|
      max_idx = i >= (shuffled.count - 1) ? 0 : i + 1

      deck = Deck.create(name: 'TEMP', user: d.user)
      d.update!(
          left: shuffled[i - 1],
          right: shuffled[max_idx],
          expected_pack: {
              pack: 0,
              cards: 15
          },
          state: 'DRAFT',
          deck: deck
      )
    end

    DraftInitializer.new.perform(shuffled, draft)

    # Start processing bots
    ProcessBotsJob.perform_later(draft_id)
  end
end
