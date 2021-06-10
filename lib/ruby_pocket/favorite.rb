require 'ruby_pocket/tag'

module RubyPocket
  class Favorite < Sequel::Model
    plugin :validation_helpers
    plugin :whitelist_security

    many_to_many :tags

    attr_writer :tag_names

    def tag_names
      @tag_names ||= [*@tag_names]
    end

    private

    def validate
      validates_presence :url
      validates_unique :url
    end

    def before_save
      name.strip! if name
    end

    def after_create
      create_tags
    end

    def create_tags
      tag_names.each do |name|
        add_tag Tag.find_or_create(name: name)
      end
    end
  end
end
