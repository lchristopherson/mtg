class Draft < ApplicationRecord
  has_many :drafters

  def self.open
    where(state: 'QUEUE').select { |draft| draft.drafters.count < 8 }
  end

  def on_player_finished
    if self.drafters.all?(&:done?)
      update!(state: 'DONE')

      CleanupDraftJob.perform_later(self.id)
    end
  end
end
