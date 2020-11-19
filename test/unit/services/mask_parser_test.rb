class TestMaskParser < Minitest::Test
  def setup
    @mask_parser = Parsers::MaskParser.new("test")
  end

  def test_insert
    assert_equal 'tes t', @mask_parser.insert(at: 3, text_to_insert: ' '), 'Should insert spaces'
    assert_equal 'tes At', @mask_parser.insert(at: -2, text_to_insert: 'A'), 'Should correctly insert at negative index'
    assert_equal 'tes At', @mask_parser.insert(at: nil, text_to_insert: nil), 'Should return original text if hash values are null'
    assert_raises ArgumentError do
      @mask_parser.insert({at: -20})
    end
  end

  def test_replace
    @mask_parser.text = 'text with some spaces'
    assert_equal 'text.with.some.spaces', @mask_parser.replace(searched: ' ', replacement: '.'), 'Replaces multiple occurences of searched string'
    assert_raises ArgumentError do
      @mask_parser.replace({text: " "})
    end
  end

  def test_remove
    @mask_parser.text = 'test'
    assert_equal 'est', @mask_parser.remove(index: 0), 'Removes character at given index'
    assert_equal 'st', @mask_parser.remove(index: 0), 'Keeps previous change'
    assert_equal 'st', @mask_parser.remove(index: 250), 'Returns unchanged string if index >= string length'
    assert_raises ArgumentError do
      @mask_parser.remove({})
    end
  end
  
end