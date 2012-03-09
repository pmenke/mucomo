# module Mucomo
module Mucomo
  
end

require 'mucomo/model.rb'
require 'mucomo/model/belongs_to_corpus.rb'
require 'mucomo/model/has_identifiers.rb'
require 'mucomo/model/corpus.rb'
require 'mucomo/model/design.rb'
require 'mucomo/model/design_component.rb'
require 'mucomo/model/resource.rb'
require 'mucomo/model/resource_allocation.rb'
require 'mucomo/model/resource_part.rb'
require 'mucomo/model/resource_part_allocation.rb'
require 'mucomo/model/trial.rb'

#puts "REQUIRING INTERFACES"
require 'mucomo/interfaces.rb'
require 'mucomo/interfaces/xml.rb'
require 'mucomo/interfaces/rdf.rb'

#puts "REQUIRING UTILS"
require 'mucomo/util.rb'
require 'mucomo/util/util.rb'
