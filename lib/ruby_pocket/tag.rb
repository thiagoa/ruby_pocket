module RubyPocket
  class Tag < Sequel::Model
    plugin :validation_helpers

    def name=(name)
      super parameterize_name(name)
    end

    private

    def parameterize_name(name)
      name
        .downcase
        .strip
        .gsub(/\s+/, ' ')
        .gsub(/[^a-z]/, '-')
        .gsub(/-+/, '-')
    end

    def validate
      validates_unique :name
    end
  end
end
