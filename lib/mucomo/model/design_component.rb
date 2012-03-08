# class DesignComponent

class Mucomo::Model::DesignComponent
  
  # @todo participant, meta, description
  
  include Mucomo::Model::HasIdentifiers
  
  #
  attr_accessor :media_type
  attr_accessor :required
  
  attr_reader :design
  
  def initialize
    @required = true
    @media_type = "undefined"
  end
  
  def required?
    @required
  end
  
  def design=(new_design)
    @design = new_design
    @design.add_design_component(self) unless @design.contains_design_component?(self)
  end
  
  # @todo access to associated allocations

  include Mucomo::Model::BelongsToCorpus

end