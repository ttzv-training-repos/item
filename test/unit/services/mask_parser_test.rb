class TestMaskParser < Minitest::Test
  def setup
    @mask_parser = Parsers::MaskParser.new("test")
  end

  def test_insert
    assert_equal "nope", @mask_parser.insert
    assert_equal "test", @mask_parser.text
  end
  
end