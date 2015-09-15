db_path = if RubyPocket.environment == 'PRODUCTION'
            "#{RubyPocket.data_dir}/pocket_production.db"
          else
            "db/pocket_#{RubyPocket.environment.downcase}.db"
          end

DB = Sequel.connect("sqlite://#{db_path}")

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
  url TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS favorites_tags(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  tag_id INTEGER,
  favorite_id INTEGER,
  FOREIGN KEY(tag_id) REFERENCES tags(id) ON DELETE CASCADE,
  FOREIGN KEY(favorite_id) REFERENCES favorites(id) ON DELETE CASCADE,
  UNIQUE(tag_id, favorite_id) ON CONFLICT REPLACE
);
SQL
