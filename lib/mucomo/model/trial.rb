# class Trial

class Mucomo::Model::Trial
  
  # this include adds the attributes id, name, title to this class.
  include Mucomo::Model::HasIdentifiers
  
  attr_accessor :serial_number # range: positive integer numbers
  
  extend Mucomo::Model::BelongsToCorpus
    
  # @todo access to containing corpus object

  # @todo access to associated designs
  
  # @todo access to associated allocations
  
  def design
    @design  
  end
  
  def design=(new_design)
    @design = Mucomo::Model::new_design
  end
  
end