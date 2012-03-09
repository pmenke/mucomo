# class Resource

class Mucomo::Model::Resource
  
  # @todo meta, description
  
  # this include adds the attributes id, name, title to this class.
  include Mucomo::Model::HasIdentifiers
  
  
  attr_accessor :media_type # media_type is a restricted vocabulary, see XML schema file
  attr_accessor :uri # the URI where this resource can be retrieved, this URI should be used as RDF uri.
  attr_reader :resource_parts # array of ResourcePart objects.
  
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