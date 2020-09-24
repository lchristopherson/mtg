require 'pack_generators/generator_map'

class PackGenerator
  class SetNotFound < Exception
    def initialize(set)
      super("Set #{set} not found in DB")
    end
  end

  def generate(set:)
    raise SetNotFound.new(set) if Card.where(set: set).empty?

    PackGenerators::GeneratorMap.generator(set: set).generate(set: set)
  end
end
