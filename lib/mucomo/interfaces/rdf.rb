require 'rdf'
require 'rdf/ntriples'
  
module Mucomo
  module Interfaces
    module RDF
      
      BASE_URI = "http://phoibos.sfb673.org/resources" # TODO correct?
      
    end
  end
  
  module Model
    
    class Corpus
      
      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays
      def as_rdf(triples)
        
        # RDF fuer dieses Objekt generieren.
        # Die Methode bekommt als Parameter ein Array, in das 
        # alle Triple reingeschrieben werden sollen, die as_rdf
        # erzeugt. Am Ende der Methode wird dieses Array dann mit
        # return wieder zurückgegeben. Wir erzeugen hier erst mal
        # keinen RDF::Graph, sondern nur dieses Array. RDF::Graph
        # wird erst später daraus hergestellt (in der Methode to_rdf).
        #
        # In das RDF sollten folgende Dinge hinein:
        #
        # 1. Alle Attribute des Objekts,
        #    also meist ID, name, title, falls vorhanden,
        #    und die anderen, falls vorhanden.
        # 2. Wenn es sich dabei selbst wieder um komplexe Objekte handelt,
        #    dann brauchen diese auch wieder eine as_rdf-Methode, die aufgerufen
        #    wird.
        
        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
        triples << [get_uri_for_rdf, "hasName", name]
        triples << [get_uri_for_rdf, "hasTitle", title]
        
        # pass complex objects along
        # pass designs along
        @designs.each do |design|
          
          # Jedes Design bekommt hier das triples-Array übergeben,
          # schreibt seine Daten hinein und gibt es mit Return wieder
          # zurück.
          
          puts "Export Design to RDF"
          triples << [get_uri_for_rdf, "hasDesign", design]
          triples = design.as_rdf(triples)
          
        end   

        # pass trials along
        @trials.each do |trial|
          
          puts "Export Trial to RDF"
          triples << [get_uri_for_rdf, "hasTrial", trial]
          triples = trial.as_rdf(triples)
          
        end        

        # pass resources along
        @resources.each do |resource|
          
          puts "Export Resource to RDF"
          triples << [get_uri_for_rdf, "hasResource", resource]
          triples = resource.as_rdf(triples)
          
        end 

        # pass resource allocations along
        @resource_allocations.each do |resource_allocation|
          
          puts "Export Resource Allocation to RDF"
          triples << [get_uri_for_rdf, "hasResourceAllocation", resource_allocation]
          triples = resource_allocation.as_rdf(triples) 
          
        end 

        # pass resource part allocations along
        @resource_part_allocations.each do |resource_part_allocation|
          
          puts "Export Resource Part Allocation to RDF"
          triples << [get_uri_for_rdf, "hasResourcePartAllocation", resource_part_allocation]
          triples = resource_part_allocation.as_rdf(triples) 
          
        end 

        # wenn fertig: volles triples-Objekt zurückgeben.
        return triples
        
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
        
      def get_uri_for_rdf
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/corpora/#{self.id}"
      end
      
    end
    
    
    # Naechste Klasse, die erweitert werden muss: Design.
    class Design
      
      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays
      def as_rdf(triples)
        
        # wie oben: RDF-Triple für alle wichtigen Daten in diesem Objekt
        # erzeugen und anschließend wieder zurückgeben.
        # hier bei Design beispielsweise: Alle Attribute (id, name, ...)
        # und dann die DesignComponents rekursiv mit each durchgehen
        # wie oben die Designs.

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
        triples << [get_uri_for_rdf, "hasName", name]
        triples << [get_uri_for_rdf, "hasTitle", title]
        triples << [get_uri_for_rdf, "creatorData", creator_data] # TODO not in design.rb yet
        triples << [get_uri_for_rdf, "productionStatus", production_status] # TODO not in design.rb yet
        triples << [get_uri_for_rdf, "description", description] # TODO not in design.rb yet

        # pass complex objects along
        # pass design components along
        @design_components.each do |design_component|
          
          puts "Export design component to RDF"
          triples << [get_uri_for_rdf, "designComponent", design_component]
          triples = design_component.as_rdf(triples)
          
        end  

        # pass meta along # TODO
        #@metas.each do |meta|
        #  
        #  puts "Export Meta to RDF"
        #  triples << [get_uri_for_rdf, "meta", meta]
        #  triples = meta.as_rdf(triples) # TODO create class
        #  
        #end    

        return triples
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end

      def get_uri_for_rdf()
        # create uri
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/designs/#{self.id}"
      end
      
    end
    
    # Und so weiter für die restlichen Model-Klassen.
    # Class Trial
    class Trial

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(triples)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
        triples << [get_uri_for_rdf, "hasName", name]
        triples << [get_uri_for_rdf, "hasTitle", title]
        triples << [get_uri_for_rdf, "serialNumber", serial_number]
        triples << [get_uri_for_rdf, "design", design]
        triples << [get_uri_for_rdf, "correspondingDesignComponent", design_component]

        return triples
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end

      def get_uri_for_rdf()
        # create uri
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/trials/#{self.id}"
      end
      
    end

    # Class Resource
    class Resource

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays            
      def as_rdf(triples)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
        triples << [get_uri_for_rdf, "hasName", name]
        triples << [get_uri_for_rdf, "hasTitle", title]
        triples << [get_uri_for_rdf, "mediaType", media_type] # TODO change to complex object MediaType?
        triples << [get_uri_for_rdf, "uri", uri]
        triples << [get_uri_for_rdf, "description", description] # TODO not in resource.rb yet

        # pass complex objects along
        # pass resource parts along
        @resource_parts.each do |resource_part|
          
          puts "Export Resource Parts to RDF"
          triples << [get_uri_for_rdf, "hasResourcePart", resource_part]
          triples = resource_part.as_rdf(triples)
          
        end   

        # pass meta along # TODO
        #@metas.each do |meta|
        #  
        #  puts "Export Meta to RDF"
        #  triples << [get_uri_for_rdf, "meta", meta]
        #  triples = meta.as_rdf(triples) # TODO create class
        #  
        #end   

        return triples
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end

      def get_uri_for_rdf()
        # create uri
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/resources/#{self.id}" # TODO eindeutig?
      end
      
    end

    # Class Resource Allocation
    class ResourceAllocation

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays            
      def as_rdf(triples)

        # convert objects to rdf 
        triples << [get_uri_for_rdf, "resource", resource]
        triples << [get_uri_for_rdf, "trial", trial]
        triples << [get_uri_for_rdf, "designComponent", design_component]

        return triples
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end

      def get_uri_for_rdf()
        # create uri
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/resource_allocations/#{self.id}"
      end
      
    end

    # Class ResourcePart Allocation
    class ResourcePartAllocation

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays            
      def as_rdf(triples)

        # convert objects to rdf 
        triples << [get_uri_for_rdf, "resourcePart", resource_part]
        triples << [get_uri_for_rdf, "trial", trial]
        triples << [get_uri_for_rdf, "designComponent", design_component]

        return triples
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end

      def get_uri_for_rdf()
        # create uri
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/resource_part_allocations/#{self.id}"
      end
      
    end
    
    # Class Design Component
    class DesignComponent

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays            
      def as_rdf(triples)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
        triples << [get_uri_for_rdf, "hasName", name]
        triples << [get_uri_for_rdf, "hasTitle", title]
        triples << [get_uri_for_rdf, "mediaType", media_type] # TODO change to complex object MediaType?
        triples << [get_uri_for_rdf, "required", required]
        triples << [get_uri_for_rdf, "design", design]
        triples << [get_uri_for_rdf, "description", description] # TODO not in design_component.rb yet

        # pass complex objects along
        # pass participants along TODO participant.rb does not exist
        @participants.each do |participant|
          
          puts "Export Participant to RDF"
          triples << [get_uri_for_rdf, "participant", participant]
          triples = participant.as_rdf(triples)
          
        end   

        # pass meta along # TODO
        #@metas.each do |meta|
        #  
        #  puts "Export Meta to RDF"
        #  triples << [get_uri_for_rdf, "meta", meta]
        #  triples = meta.as_rdf(triples) # TODO create class
        #  
        #end   

        return triples
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end

      def get_uri_for_rdf()
        # create uri
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/design_components/#{self.id}"
      end
      
    end

    # Class ResourcePart
    class ResourcePart

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays            
      def as_rdf(triples)

        # convert objects to rdf 
        triples << [get_uri_for_rdf, "hasId", id]
        triples << [get_uri_for_rdf, "hasName", name]
        triples << [get_uri_for_rdf, "hasTitle", title]
        triples << [get_uri_for_rdf, "internalLocation", internal_location]

        return triples
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end

      def get_uri_for_rdf()
        # create uri
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/resource_parts/#{self.id}"
      end
      
    end

    # Class Participant
    class Participant

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays            
      def as_rdf(triples)
        # convert objects to rdf 
        triples << [get_uri_for_rdf, "hasId", id]
        triples << [get_uri_for_rdf, "hasName", name]
        triples << [get_uri_for_rdf, "code", code]

        # pass complex objects along
        # pass participant values along  # TODO there is no participantValue.rb yet
        @participantValues.each do |participant_value|
          
          puts "Export Participant Value to RDF"
          triples << [get_uri_for_rdf, "participantValue", participant_value]
          triples = participant_value.as_rdf(triples)
          
        end   

        return triples
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end

      def get_uri_for_rdf()
        # create uri
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/participants/#{self.id}"
      end
      
    end

    # Class ParticipantValue
    class ParticipantValue

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays            
      def as_rdf(triples)

        # convert objects to rdf TODO

        return triples
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end

      def get_uri_for_rdf()
        # create uri
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/participant_values/#{self.id}"
      end
      
    end

    # Class Meta Entry
    class MetaEntry

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays            
      def as_rdf(triples)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "key", key]
        triples << [get_uri_for_rdf, "isocat", isocat]

        return triples
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end

      def get_uri_for_rdf()
        # create uri
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/meta_entries/#{self.id}"
      end
      
    end

  end

end

