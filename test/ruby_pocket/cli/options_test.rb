require 'test_helper'
require 'ruby_pocket/cli/options'

module RubyPocket
  module Cli
    class OptionsTest < DefaultTestCase
      def test_has_an_action
        options = Options.new
        options.action = :add

        assert_equal :add, options.action
      end

      def test_cant_assign_two_subsequent_actions
        options = Options.new
        options.action = :add

        error = assert_raises(ArgumentError) do
          options.action = :list
        end

        assert_match %r(list and add), error.message
      end

      def test_validate_fails_when_has_no_action
        options = Options.new

        error = assert_raises(ArgumentError) do
          options.validate!
        end

        assert_match %r(supply an action), error.message
      end

      def test_validate_succeeds_when_has_an_action
        options = Options.new
        options.action = :add

        assert_nil options.validate!
      end

      def test_has_a_values_hash
        options = Options.new

        assert_equal Hash.new, options.values
      end
    end
  end
end
