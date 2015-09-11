DB = Sequel.connect "sqlite://db/pocket_#{RubyPocket.environment.downcase}.db"

Sequel::Model :validation_helpers

DB.run <<-SQL
CREATE TABLE IF NOT EXISTS tags(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) UNIQUE
);

CREATE TABLE IF NOT EXISTS favorites(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  summary TEXT,
  url TEXT
);

CREATE TABLE IF NOT EXISTS favorites_tags(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  tag_id INTEGER,
  favorite_id INTEGER,
  FOREIGN KEY(tag_id) REFERENCES tags(id),
  FOREIGN KEY(favorite_id) REFERENCES favorites(id)
);
SQL
