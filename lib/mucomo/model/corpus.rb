# class Corpus

class Mucomo::Model::Corpus
  
  # this include adds the attributes id, name, title to this class.
  include Mucomo::Model::HasIdentifiers
  
  attr_reader :properties # array of property objects. not yet implemented.
  attr_reader :designs # array of Design objects.
  attr_reader :trials # array of Trial objects.
  attr_reader :resources # array of Resource objects.
  attr_reader :resource_allocations # array of ResourceAllocation objects.
  attr_reader :resource_part_allocations # array of ResourcePartAllocation objects.
  
  def initialize
    puts "New Corpus!"
    @properties = Hash.new
    @designs = Array.new
    @trials = Array.new
    @resources = Array.new
    @resource_allocations = Array.new
    @resource_part_allocations = Array.new
  end
  
  def allocations
    @resource_allocations + @resource_part_allocations
  end
  
  def add_property(key, value)
    @properties[key] = value
  end
  
  def add_design(design)
    @designs << design unless @designs.include?(design)
  end
  
  def add_trial(trial)
    @trials << trial unless @trials.include?(trial)
  end
  
  def add_resource(resource)
    @resources << resource unless @resources.include?(resource)
  end
  
  def contains_design?(design)
    return @designs.include?(design)
  end
  
  def contains_trial?(trial)
    return @trials.include?(trial)
  end
  
  def contains_resource?(resource)
    return @resources.include?(resource)
  end
  
  # the following helper methods are necessary:
  #
  # get_resources_for_trial
  # get_trial_for_resource
  # get_design_components_for_trial
  # get_design_for_trial
  
  def trials_for_design(d)
    @trials.select{ |t| t.design and t.design==d }
  end
  
end