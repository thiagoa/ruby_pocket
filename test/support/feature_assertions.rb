module FeatureAssertions
  private

  def build_favorite_regex(favorite)
    tags = Regexp.union(*favorite.tags.map(&:name))
    %r(#{favorite.id}.+#{favorite.name}.+#{tags})
  end

  def assert_shows_favorite(favorite, output)
    message = "Favorite '#{favorite.name}' is not on the output. Should be."
    favorite_regex = build_favorite_regex(favorite)

    assert_match favorite_regex, output.stdout, message
  end

  def assert_not_shows_favorite(favorite, output)
    message = "Favorite '#{favorite.name}' is on the output. Shouldn't be."
    favorite_regex = build_favorite_regex(favorite)

    assert_not_match favorite_regex, output.stdout, message
  end
end
