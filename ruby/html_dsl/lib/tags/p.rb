require_relative 'tag'

class P < Tag.new(:p)
  valid_tag :a
end
