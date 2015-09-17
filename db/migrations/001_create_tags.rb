Sequel.migration do
  up do
    unless table_exists?(:tags)
      create_table :tags do
        primary_key :id

        String :name, unique: true
      end
    end
  end

  down do
    drop_table :tags
  end
end
