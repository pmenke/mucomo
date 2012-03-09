require 'rdf'
require 'rdf/ntriples'
  
module Mucomo
  module Interfaces
    module RDF
      
      BASE_URI = "http://phoibos.sfb673.org"
      
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
        
        # Beispiel einfaches Attribut:
        triples << [ get_uri_for_rdf, "hasId", id ]
        
        # Komplexe Objekte per Rekursion und "Weiterreichen"
        @designs.each do |design|
          
          # Jedes Design bekommt hier das triples-Array übergeben,
          # schreibt seine Daten hinein und gibt es mit Return wieder
          # zurück.
          
          puts "Export Design to RDF"
          triples = design.as_rdf(triples)
          
        end
        
        # ... hier noch die restlichen Objekte zu RDF konvertieren
        
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
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/corpora/#{self.name}"
      end
      
    end
    
    
    # Naechste Klasse, die erweitert werden muss: Design.
    class Design
      
      def as_rdf(triples)
        
        # wie oben: RDF-Triple für alle wichtigen Daten in diesem Objekt
        # erzeugen und anschließend wieder zurückgeben.
        # hier bei Design beispielsweise: Alle Attribute (id, name, ...)
        # und dann die DesignComponents rekursiv mit each durchgehen
        # wie oben die Designs.
        
        triples << [get_uri_for_rdf, "hasId", id]
        return triples
      end
      
      def get_uri_for_rdf()
        # URI fuer dieses Objekt anhand des per Mail geschickten Dokuments erzeugen
        #@todo Richtige URI erzeugen
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/foo/#{id}"
      end
      
    end
    
    # Und so weiter für die restlichen Model-Klassen.
    
  end


end

