Sequel.migration do
  up do
    unless table_exists?(:favorites)
      create_table :favorites do
        primary_key :id

        String :name, text: true
        String :summary, text: true
        String :url, text: true, unique: true
      end
    end
  end

  down do
    drop_table :favorites
  end
end
