module RubyPocket
  class Tag < Sequel::Model
    plugin :validation_helpers

    def before_save
      name.strip!
    end

    private

    def validate
      validates_unique :name
    end
  end
end
