# class ResourceAllocation

class Mucomo::Model::ResourceAllocation
  
  attr_reader :resource
  attr_reader :trial
  attr_reader :design_component

  def initialize(params_hash)
    @resource_part = params_hash[:resource] if params_hash.contains_key?(:resource)
    @trial = params_hash[:trial] if params_hash.contains_key?(:trial)
    @design_component = params_hash[:design_component] if params_hash.contains_key?(:design_component)
  end
  
  # @todo access to containing corpus object

  # @todo access to associated trial

  # @todo access to associated design component

  # @todo access to associated resource
  
end