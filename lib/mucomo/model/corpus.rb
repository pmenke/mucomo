# class Corpus

class Mucomo::Model::Corpus
  
  include Mucomo::Model::HasIdentifiers
  
  attr_reader :properties
  attr_reader :designs
  attr_reader :trials
  attr_reader :resources
  attr_reader :resource_allocations
  attr_reader :resource_part_allocations
  
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