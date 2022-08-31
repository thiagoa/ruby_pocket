module OS
  def self.os
    return :windows if windows?
    return :mac if mac?
    return :linux if linux?
  end

  def self.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def self.mac?
    (/darwin|mac os/ =~ RUBY_PLATFORM) != nil
  end

  def self.unix?
    !OS.windows?
  end

  def self.linux?
    unix? and !mac?
  end
end
