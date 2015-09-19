db_path = if RubyPocket.environment.production?
            [RubyPocket.data_dir, 'pocket_production.db']
          else
            ['db', "pocket_#{RubyPocket.environment.downcase}.db"]
          end

DB = Sequel.connect("sqlite://#{File.join(*db_path)}")

Sequel::Model :validation_helpers
Sequel.extension :migration

Pathname(__dir__).join('../db/migrations').tap do |migrations_path|
  unless Sequel::Migrator.is_current?(DB, migrations_path)
    Sequel::Migrator.run(DB, migrations_path)
  end
end
