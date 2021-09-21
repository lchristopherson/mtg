class DraftInitializer
  def perform(drafters, draft)
    case draft.data['type']
    when 'normal'
      drafters.each do |d|
        GeneratePackJob.new.perform(d.id, 'LEFT')
      end
    when 'cube'
      CubeGenerators::DefaultGenerator.new.generate(drafters, draft)
    else
      raise "Unknown draft type: #{draft.data['type']}"
    end
  end
end
