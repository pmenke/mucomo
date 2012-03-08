require 'helper'

class TestExampleCorpus < Test::Unit::TestCase
  
  include Mucomo::Model
  include Mucomo::Interfaces::XML
  

  def setup
    @corpus = Corpus.new
    @corpus.name = "Example"
    @design = Design.new
    @design.name = "ExampleDesign"
    @design.id = "design0001"
    @design_component_1 = DesignComponent.new
    @design_component_1.id = "designcomponent0001"
    @design_component_1.name = "Video-DC"
    @design_component_1.media_type = "video"
    @design.add_design_component(@design_component_1)
    @design_component_2 = DesignComponent.new
    @design_component_2.id = "designcomponent0002"
    @design_component_2.name = "Annotation-DC"
    @design_component_2.media_type = "annotation"
    @design.add_design_component(@design_component_2)
    @corpus.add_design @design
    @trials = Array.new
    (0..3).each do |n|
      @trials << Trial.new
      @trials[n].id = "trial#{n+1}"
      @trials[n].name = "V#{n+1}"
      @corpus.add_trial @trials[n]
    end
    
    @resource_1 = Resource.new
    @resource_1.id = "resource0001"
    @resource_1.name = "V1K1.mov"
    @resource_1.media_type = "video"
    @resource_1.uri = "http://foo.bar/resources/1"
    @corpus.add_resource @resource_1
    
    @resource_2 = Resource.new
    @resource_2.id = "resource0002"
    @resource_2.name = "V1.eaf"
    @resource_2.media_type = "annotation"
    @resource_2.uri = "http://foo.bar/resources/2"
    @corpus.add_resource @resource_2
    
    @resource_part_1 = ResourcePart.new
    @resource_part_1.id = "resourcepart0001"
    @resource_part_1.name = "LayerASpeech"
    @resource_part_1.internal_location = "layer:A.Speech"
    @resource_2.add_resource_part @resource_part_1
    
    @resource_part_2 = ResourcePart.new
    @resource_part_2.id = "resourcepart0002"
    @resource_part_2.name = "LayerBSpeech"
    @resource_part_2.internal_location = "layer:B.Speech"
    @resource_2.add_resource_part @resource_part_2
    
  end

  def test_example_corpus_construction
    
    assert_equal "Example", @corpus.name
    assert_equal 1, @corpus.designs.size
    assert_equal "ExampleDesign", @corpus.designs[0].name
    assert_equal 2, @corpus.designs[0].design_components.size
    assert_equal 4, @corpus.trials.size
    assert_equal "V1", @corpus.trials[0].name
    
    puts @corpus.to_yaml
    
  end
  
  def test_export_example_corpus
    # puts @corpus.methods
    @corpus.to_xml("/Users/pmenke/MucomoExampleCorpus.xml")
  end

end
