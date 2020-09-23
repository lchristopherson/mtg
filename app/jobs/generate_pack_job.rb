class GeneratePackJob < ApplicationJob
  queue_as :default

  def perform(drafter_id, direction)
    drafter = Drafter.find(drafter_id)
    draft = drafter.draft

    generator = PackGenerator.new

    pack = generator.generate(set: draft.data['sets'][drafter.pack_number])
    pack.drafter = drafter
    pack.pass_direction = direction
    pack.number = drafter.pack_number
    pack.save!

    drafter.update!(
        pack_number: drafter.pack_number + 1,
    )
  end
end
