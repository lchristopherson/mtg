require 'pack_generators/generator_map'

class PackGenerator
  class SetNotFound < Exception
    def initialize(set)
      super("Set #{set} not found in DB")
    end
  end

  def generate(set:)
    raise SetNotFound.new(set) unless MtgSet.find_by_code(set)

    PackGenerators::GeneratorMap.generator(set: set).generate(set: set)
  end
end
