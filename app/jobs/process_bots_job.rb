class ProcessBotsJob < ApplicationJob
  queue_as :default

  retry_on Exception

  # TODO process bots in table order
  # Or one job per bot
  def perform(draft_id)
    draft = Draft.find(draft_id)
    bots = BotDrafter.where(draft: draft)

    bots.shuffle.each do |bot|
      while (pack = bot.next_pack) != nil
        bot.pick_card(pack)
      end
    end

    unless bots.reload.all? { |b| b.done? }
      ProcessBotsJob.set(wait: 5.seconds).perform_later(draft_id)
    end
  end
end
