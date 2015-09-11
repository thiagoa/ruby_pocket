module RubyPocket
  class Tag < Sequel::Model
    def before_save
      name.strip!
    end
  end
end
