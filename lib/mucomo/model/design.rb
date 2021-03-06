# class Design

class Mucomo::Model::Design
  
  # @todo meta, description
  # @todo creator data, production status
  
  # this include adds the attributes id, name, title to this class.
  include Mucomo::Model::HasIdentifiers
  
  attr_reader :design_components # array of DesignComponent objects
  
  def initialize
    @design_components = Array.new
  end
  
  def add_design_component(design_component)
    design_component.corpus=corpus if has_corpus?
    @design_components << design_component
  end
  
  def contains_design_component?(design_component)
    return @design_components.include?(design_component)
  end
  
  def trials
    @corpus.trials_for_design(self)
  end
  
  include Mucomo::Model::BelongsToCorpus
  
end