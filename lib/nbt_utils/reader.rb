# frozen_string_literal: true

module NBTUtils
  class Reader
    attr_reader :tag

    def initialize(input)
      @content = input.is_a?(String) ? StringIO.new(input) : input
    end

    def read
      last_byte = content.read(1).bytes.first
      klass = NBTUtils::Tag.tag_type_to_class(last_byte)

      @tag = klass.new(content, named: true)
      self
    end

    private

    attr_reader :content
  end
end
