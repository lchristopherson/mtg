require_relative 'default_pack_generator'
require_relative 'znr_pack_generator'

class GeneratorMap
  MAP = {
      'znr' => ZNRPackGenerator
  }

  def self.generator(set:)
    (MAP[set] || DefaultPackGenerator).new
  end
end
