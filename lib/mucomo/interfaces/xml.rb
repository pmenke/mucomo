require 'libxml'

puts "REQUIRING XML"
module Mucomo
  module Interfaces
    module XML
  
      def self.from_xml(file)
    
      end
      
      
      def adopt_all(object, node, attribute_names)
        attribute_names.each do |n|
          self.adopt(object, node, n)
        end
      end
      
      def adopt(object, node, attribute_name, xml_attribute_name = nil)
        if object.respond_to? attribute_name
          if xml_attribute_name == nil
            node.attributes[attribute_name] = object.send(attribute_name).to_s
          else
            node.attributes[xml_attribute_name] = object.send(attribute_name).to_s
          end
        end
      end
  
      def as_xml(root)
    
        props_node = LibXML::XML::Node.new('Meta')
        properties.each do |key, value|
          # @TODO props_node << design.as_xml
        end
        root << props_node
        
        root << LibXML::XML::Node.new('Participants')
    
        designs_node = LibXML::XML::Node.new('Designs')
        designs.each do |design|
          designs_node << design.as_xml
        end
        root << designs_node
    
        trials_node = LibXML::XML::Node.new('Trials')
        trials.each do |trial|
          trials_node << trial.as_xml
        end
        root << trials_node
        
        resources_node = LibXML::XML::Node.new('Resources')
        resources.each do |resource|
          resources_node << resource.as_xml
        end
        root << resources_node
        
      end
  
      def to_xml(target_object)

        document = LibXML::XML::Document.new
        document.root = LibXML::XML::Node.new('Corpus')
    
        as_xml(document.root)
    
        # write out that document
        if target_object.is_a? File
          output_file = target_object
        end
        if target_object.is_a? String
          output_file = File.new(target_object, 'w')
        end
        output_file << document.to_s
        output_file.close
      end
    end
  end

  module Model
    
    
    
    class Corpus
      #puts "ADDING XML METHODS"
      include Mucomo::Interfaces::XML
      c = Mucomo::Model::Corpus.new
      #puts c.methods
      #puts Mucomo::Model::Corpus.methods
    end
    
    class Design
      include Mucomo::Interfaces::XML
      def as_xml()
        node = LibXML::XML::Node.new('Design')
        adopt_all self, node, %w(id name)
        design_components.collect{|c| c.as_xml }.each{|n| node << n }
        return node
      end
    end
    
    class DesignComponent
      include Mucomo::Interfaces::XML
      def as_xml()
        node = LibXML::XML::Node.new('DesignComponent')
        adopt_all self, node, %w(id name participant required)
        adopt self, node, "media_type", "mediatype"
        return node
      end
    end
    
    
    class Trial
      include Mucomo::Interfaces::XML
      def as_xml()
        node = LibXML::XML::Node.new('Trial')
        adopt_all self, node, %w(id name)
        return node
      end
    end
    
    class Resource
      include Mucomo::Interfaces::XML
      def as_xml()
        node = LibXML::XML::Node.new('Resource')
        adopt_all self, node, %w(id name uri)
        adopt self, node, "media_type", "mediatype"
        resource_parts.collect{|c| c.as_xml }.each{|n| node << n }
        return node
      end
    end
    
    class ResourcePart
      include Mucomo::Interfaces::XML
      def as_xml()
        node = LibXML::XML::Node.new('ResourcePart')
        adopt_all self, node, %w(id name)
        adopt self, node, "internal_location", "internallocation"
        return node
      end
    end
    
  end
end