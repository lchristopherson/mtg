class Draft < ApplicationRecord
  has_many :drafters

  def self.open
    where(state: 'QUEUE').select { |draft| draft.drafters.count < 8 }
  end

  def on_player_finished
    if self.drafters.all?(&:done?)
      update!(state: 'DONE')
    end
  end

  def end_draft
    # Delete Drafters
    Drafter.all.map { |d| d.update(left: nil, right: nil); d }.each { |d| d.delete }
  end
end
