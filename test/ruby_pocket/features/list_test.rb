require 'test_helper'
require 'support/favorite_factory'
require 'ruby_pocket/favorite'

module RubyPocket
  module Cli
    class ListTest < FeatureTestCase
      include FavoriteFactory

      def test_lists_available_favorites_with_id_name_and_tags
        values = build_values(tag_names: %w(ruby))
        favorite = create_favorite(values)

        output = run_command('pocket -l')

        assert_shows_favorite favorite, output
      end

      def test_shows_message_when_has_no_favorites
        output = run_command('pocket -l')

        assert_match %r(is empty), output.stdout
      end

      def test_searches_for_favorites_by_tags
        values = {
          name: 'Ruby Tapas',
          url: 'http://www.rubytapas.com',
          tag_names: %w(ruby)
        }
        ruby_tapas_favorite = create_favorite(values)

        values = {
          name: 'Martin Fowler - Microservices article',
          url: 'http://martinfowler.com/articles/microservices.html',
          tag_names: %w(microservices)
        }
        microservices_favorite = create_favorite(values)

        output = run_command('pocket -l -t microservices')

        assert_not_shows_favorite ruby_tapas_favorite, output
        assert_shows_favorite microservices_favorite, output
      end

      def test_searches_for_favorites_by_more_than_one_tag
        values = {
          name: 'Ruby Tapas',
          url: 'http://www.rubytapas.com',
          tag_names: %w(ruby screencasts)
        }
        ruby_tapas_favorite = create_favorite(values)

        values = {
          name: 'Ruby Flow',
          url: 'http://www.rubyflow.com',
          tag_names: %w(ruby aggregator)
        }
        ruby_flow_favorite = create_favorite(values)

        output = run_command('pocket -l -t ruby,screencasts')

        assert_shows_favorite ruby_tapas_favorite, output
        assert_not_shows_favorite ruby_flow_favorite, output
      end

      def test_shows_an_error_when_tag_not_found
        output = run_command('pocket -l -t microservices')

        assert_match %r(Tag.+not found), output.stderr
        assert_empty output.stdout
      end
    end
  end
end
