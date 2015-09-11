module CustomAssertions
  def assert_subset(subset, collection)
    assert_equal(
      collection,
      collection.merge(subset),
      'Subset is not included in collection'
    )
  end
end
