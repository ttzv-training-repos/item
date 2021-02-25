module Scrubbers
  class ItemScrubber < Loofah::Scrubbers::Prune

    attr_accessor :itemtag_list
    def initialize
      super
      @itemtag_list = Array.new
    end

    def scrub(node)
      return CONTINUE if html5lib_sanitize(node) == CONTINUE
      return CONTINUE if @itemtag_list.include?(node.name)
      node.remove
      return STOP
    end

  end
end
