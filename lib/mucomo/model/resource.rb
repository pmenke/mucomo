# class Resource

class Mucomo::Model::Resource
  
  # @todo meta, description
  
  include Mucomo::Model::HasIdentifiers
  
  #
  attr_accessor :media_type
  attr_accessor :uri
  attr_reader :resource_parts
  
  def initialize
    @resource_parts = Array.new
  end
  
  # @todo access to associated allocations
  
  # @todo access to child resource parts
  
  def add_resource_part(part)
    part.corpus=corpus if has_corpus?
    part.resource = self
    @resource_parts << part
  end
  
  def has_resource_parts?
    return !@resource_parts.empty?
  end

  include Mucomo::Model::BelongsToCorpus

end