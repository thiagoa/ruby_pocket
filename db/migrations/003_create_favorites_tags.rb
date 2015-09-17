Sequel.migration do
  up do
    run <<-SQL
    CREATE TABLE IF NOT EXISTS favorites_tags(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      tag_id INTEGER,
      favorite_id INTEGER,
      FOREIGN KEY(tag_id) REFERENCES tags(id) ON DELETE CASCADE,
      FOREIGN KEY(favorite_id) REFERENCES favorites(id) ON DELETE CASCADE,
      UNIQUE(tag_id, favorite_id) ON CONFLICT REPLACE
    )
    SQL
  end

  down do
    run <<-SQL
    DROP TABLE favorites_tags
    SQL
  end
end
