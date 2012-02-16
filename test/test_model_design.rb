require 'helper'

class TestModelDesign < Test::Unit::TestCase

  def setup
    @design = Mucomo::Model::Design.new
  end

  def test_design_responds_to_attributes
    assert_equal true, @design.is_a?(Mucomo::Model::Design)
    
    assert_respond_to @design, :add_design_component
    assert_respond_to @design, :contains_design_component?
    
  end

end
