# class ResourcePart

class Mucomo::Model::ResourcePart
  
  # this include adds the attributes id, name, title to this class.
  include Mucomo::Model::HasIdentifiers
  
  attr_accessor :internal_location # a string describing the internal location of the resource part inside the file.
  
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