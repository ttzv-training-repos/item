class TestMaskParser < Minitest::Test
  def setup
    @mask_parser = Parsers::MaskParser.new("test")
  end

  def test_insert
    assert_equal "nope", @mask_parser.insert
  end
  
end