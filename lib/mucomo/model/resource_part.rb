# class ResourcePart

class Mucomo::Model::ResourcePart
  
  include Mucomo::Model::HasIdentifiers
  
  attr_accessor :internal_location
  
  def resource
    @resource
  end
  
  def resource=(new_resource)
    @resource = new_resource
  end
  
  # @todo access to containing corpus object

  # @todo access to associated resource
  
  include Mucomo::Model::BelongsToCorpus
  
end