# class Trial

class Mucomo::Model::Trial
  
  include Mucomo::Model::HasIdentifiers
  
  #
  attr_accessor :identifier
  
  attr_accessor :serial_number
  
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