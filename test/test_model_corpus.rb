require 'helper'

class TestModelCorpus < Test::Unit::TestCase

  include Mucomo::Model

  def setup
    @corpus = Corpus.new
    
    @design = Design.new
    
  end

  def test_corpus_responds_to_attributes
    
    assert_respond_to @corpus, :designs
    assert_respond_to @corpus, :trials
    assert_respond_to @corpus, :resources
    assert_respond_to @corpus, :resource_allocations
    assert_respond_to @corpus, :resource_part_allocations
    assert_respond_to @corpus, :allocations
    
    assert_equal true, @corpus.designs.is_a?(Array)
    assert_equal true, @corpus.trials.is_a?(Array)
    assert_equal true, @corpus.resources.is_a?(Array)
    assert_equal true, @corpus.resource_allocations.is_a?(Array)
    assert_equal true, @corpus.resource_part_allocations.is_a?(Array)
    assert_equal true, @corpus.allocations.is_a?(Array)
    
  end

  def test_responds_to_designs_add_and_contains_methods
    
    # test for the existence of methods needed later in this test
    assert_respond_to @corpus, :add_design
    assert_respond_to @corpus, :contains_design?
    
  end
  
  def test_designs_add_and_contains_methods
    
    n = @corpus.designs.size
    design = Design.new
    @corpus.add_design(design)
    # now the corpus should have exactly one design more.
    assert_equal 1, (@corpus.designs.size-n)
    # now the corpus should return true for contains_design?
    assert_equal true, @corpus.contains_design?(design)
    
  end
  
  def test_responds_to_trials_add_and_contains_methods
    
    # test for the existence of methods needed later in this test
    assert_respond_to @corpus, :add_trial
    assert_respond_to @corpus, :contains_trial?
  
  end
  
  def test_trials_add_and_contains_methods
  
    n = @corpus.trials.size
    trial = Trial.new
    @corpus.add_trial(trial)
    # now the corpus should have exactly one trial more.
    assert_equal 1, (@corpus.trials.size-n)
    # now the corpus should return true for contains_trial?
    assert_equal true, @corpus.contains_trial?(trial)
    
  end
  
  def test_responds_to_resources_add_and_contains_methods
    
    # test for the existence of methods needed later in this test
    assert_respond_to @corpus, :add_resource
    assert_respond_to @corpus, :contains_resource?
    
  end
  
  def test_resources_add_and_contains_methods
    
    n = @corpus.resources.size
    resource = Resource.new
    @corpus.add_resource(resource)
    # now the corpus should have exactly one resource more.
    assert_equal 1, (@corpus.resources.size-n)
    # now the corpus should return true for contains_resource?
    assert_equal true, @corpus.contains_resource?(resource)
    
  end
  

end
