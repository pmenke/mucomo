# class DesignComponent

class Mucomo::Model::DesignComponent
  
  # @todo participant, meta, description
  
  # this include adds the attributes id, name, title to this class.
  include Mucomo::Model::HasIdentifiers
  
  attr_accessor :media_type # media_type's range is a restricted vocabulary, see XML schema file
  attr_accessor :required # boolean
  
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