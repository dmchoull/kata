require_relative 'tag'

class H1 < Tag.new(:h1)
  valid_tag :a
end
