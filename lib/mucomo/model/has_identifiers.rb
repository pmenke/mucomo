module Mucomo::Model::HasIdentifiers
  
  attr_accessor :id, :name, :title
  
  def has_name?
    return name!=nil
  end
  
  def has_title?
    return title!=nil
  end
  
end