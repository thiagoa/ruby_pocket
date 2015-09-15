module RubyPocket
  class Environment < String
    ALL = %w(PRODUCTION DEVELOPMENT TEST)

    ALL.each do |env|
      define_method "#{env.downcase}?" do
        self == env
      end
    end
  end
end
