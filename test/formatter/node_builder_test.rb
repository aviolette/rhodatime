require_relative '../../lib/formatter/node_builder'
require_relative '../../lib/rhodatime'
require 'minitest/autorun'

module RhodaTime
  module Formatter
    class TestNodeBuilder < Minitest::Test

      def test_year_small
        nodes = NodeBuilder.build_nodes("YYYY-MM-dd")
      end

    end
  end
end
