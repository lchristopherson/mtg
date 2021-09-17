module CubeGenerators
  class DefaultGenerator
    def generate(drafters, draft)
      # TODO: Ensure cube exists
      cube = Cube.find_by_name(draft.data['cube'])

      cards = cube.cards.to_a.shuffle

      drafters.each do |drafter|
        packs = [
            assemble_pack(drafter, cards.pop(15), 'LEFT', 0),
            assemble_pack(drafter, cards.pop(15), 'RIGHT', 1),
            assemble_pack(drafter, cards.pop(15), 'LEFT', 2),
        ]

        drafter.packs += packs
      end
    end

    private

    def assemble_pack(drafter, cards, direction, number)
      pack = Pack.create!(
          drafter_id: drafter.id,
          pass_direction: direction,
          number: number
      )

      pack.cards += cards

      pack
    end
  end
end
