require_relative 'tag'

class Document < Tag.new(:html)
  valid_tags :h1, :p, :ul, :a
end
