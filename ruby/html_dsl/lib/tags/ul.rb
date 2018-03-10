require_relative 'tag'

class UL < Tag.new(:ul)
  valid_tag :li
end
