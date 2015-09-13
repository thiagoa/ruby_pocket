require 'test_helper'
require 'ruby_pocket/favorite'

module RubyPocket
  module Cli
    class AddTest < FeatureTestCase
      def test_adds_a_favorite
        url = 'http://www.rubytapas.com'
        title = 'Ruby Tapas'

        output = run_command_web_mocked("pocket -a #{url}", url, title)

        assert_match %r(Ruby Tapas.+created), output.stdout
        assert Favorite.find(name: 'Ruby Tapas')
      end

      def test_adds_a_favorite_with_name_and_tags
        url = 'http://www.fancyname.com'

        output = run_command("pocket -a #{url} -n 'Fancy Name' -t ruby")
        added_favorite = Favorite.find(name: 'Fancy Name')

        assert_match %r(Fancy Name.+created), output.stdout
        assert added_favorite
        assert_equal %w(ruby), added_favorite.tags.map(&:name)
      end

      private

      def run_command_web_mocked(command, url, title)
        run_command(
          command,
          MOCK_FEATURE: 'add',
          WEB_MOCK_URL: url,
          WEB_MOCK_PAGE_TITLE: title
        )
      end
    end
  end
end
