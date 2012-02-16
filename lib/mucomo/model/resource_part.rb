# class ResourcePart

class Mucomo::Model::ResourcePart
  
  attr_accessor :internal_location
  
  def resource
    @resource
  end
  
  private
  
  def resource=(new_resource)
    @resource = new_resource
  end
  
  # @todo access to containing corpus object

  # @todo access to associated resource
  
end