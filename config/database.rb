db_path = if RubyPocket.environment.production?
            [RubyPocket.data_dir, 'pocket_production.db']
          else
            ['db', "pocket_#{RubyPocket.environment.downcase}.db"]
          end

DB = Sequel.connect("sqlite://#{File.join(*db_path)}")

Sequel::Model :validation_helpers
Sequel.extension :migration

unless Sequel::Migrator.is_current?(DB, 'db/migrations')
  Sequel::Migrator.run(DB, 'db/migrations')
end
