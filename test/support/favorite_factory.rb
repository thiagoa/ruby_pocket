module FavoriteFactory
  private

  def create_favorite(values = build_values)
    RubyPocket::Favorite.create values
  end

  def build_values(values = {})
    {
      name: 'Ruby Flow',
      url: 'http:///www.rubyflow.com'
    }.merge(values)
  end
end
