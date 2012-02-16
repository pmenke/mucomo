# class Design

class Mucomo::Model::Design
  
  attr_reader :name
  attr_reader :design_components
  
  def initialize
    @design_components = Array.new
  end
  
  def add_design_component(design_component)
    @design_components << design_component
  end
  
  def contains_design_component?(design_component)
    return @design_components.include?(design_component)
  end
  
  # @todo access to containing corpus object
  
  # @todo access to associated trials
  
end