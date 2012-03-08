# class ResourcePartAllocation

class Mucomo::Model::ResourcePartAllocation

  include Mucomo::Model::HasIdentifiers
  
  attr_reader :resource_part
  attr_reader :trial
  attr_reader :design_component

  def initialize(params_hash)
    @resource_part = params_hash[:resource_part] if params_hash.contains_key?(:resource_part)
    @trial = params_hash[:trial] if params_hash.contains_key?(:trial)
    @design_component = params_hash[:design_component] if params_hash.contains_key?(:design_component)
  end
  
  include Mucomo::Model::BelongsToCorpus

  # @todo access to associated trial

  # @todo access to associated design component

  # @todo access to associated resource part
  
  
end