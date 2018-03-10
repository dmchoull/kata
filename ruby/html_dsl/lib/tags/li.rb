require_relative 'tag'

class LI < Tag.new(:li)
  valid_tags :h1, :p, :a, :ul
end
