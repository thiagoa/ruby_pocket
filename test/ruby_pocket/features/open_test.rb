require 'test_helper'
require 'support/favorite_factory'
require 'ruby_pocket/favorite'

module RubyPocket
  module Cli
    class OpenTest < FeatureTestCase
      include FavoriteFactory

      def test_opening_url
        favorite = create_favorite

        output = run_command("pocket -o #{favorite.id}")

        assert_empty output.stderr
        assert_empty output.stdout
      end
    end
  end
end
