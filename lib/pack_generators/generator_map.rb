require_relative 'default_pack_generator'
require_relative 'znr_pack_generator'

module PackGenerators
  class GeneratorMap
    MAP = {
        'znr' => ZnrPackGenerator
    }

    def self.generator(set:)
      (MAP[set] || DefaultPackGenerator).new
    end
  end
end
