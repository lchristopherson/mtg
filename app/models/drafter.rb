class Drafter < ApplicationRecord
  belongs_to :draft
  belongs_to :deck, optional: true
  has_one :left, class_name: 'Drafter', foreign_key: 'left_id'
  has_one :right, class_name: 'Drafter', foreign_key: 'right_id'
  has_many :packs

  def self.in_active_draft?(user)
    where('user = ? AND state != ?', user, 'DONE').any?
  end

  def next_pack
    all = ordered_packs
    return nil if all.empty?
    return nil unless all.first.matches(self.expected_pack)

    all.first
  end

  def next_drafter(pack)
    if pack.pass_direction == 'LEFT'
      self.left
    else
      self.right
    end
  end

  def handle_pick(pack, mtg_id)
    card = pack.get_card(mtg_id)

    # Remove card from pack
    # If duplicate cards in pack may need to delete only one??
    pack.cards.delete(card)

    # Add card to deck
    self.deck.cards.push(card)

    if pack.empty?
      pack.delete

      handle_empty_pack(pack)
    else
      # Pass the pack
      pack.update!(drafter: next_drafter(pack))

      update!(expected_pack: {
          pack: pack.number,
          cards: pack.cards.count
      })
    end
  end

  def handle_empty_pack(pack)
    if pack.number >= 2
      # Draft is over
      update!(state: 'DONE')

      self.draft.on_player_finished

      return
    end

    # Update drafter's expected next pack
    update!(expected_pack: {
        pack: pack.number + 1,
        cards: 15
    })

    # Generate pack for next drafter
    GeneratePackJob.perform_later(next_drafter(pack).id, pack.opposite_direction)
  end

  def done?
    self.state == 'DONE'
  end

  private

  def ordered_packs
    self.reload.packs.sort { |a, b| [a.number, 15 - a.cards.count] <=> [b.number, 15 - b.cards.count] }
  end
end
