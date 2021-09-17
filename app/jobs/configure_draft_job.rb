class ConfigureDraftJob < ApplicationJob
  queue_as :default

  def perform(draft_id, drafter_ids)

  end
end
