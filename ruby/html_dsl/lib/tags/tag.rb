class Tag
  def self.new(name)
    tag_class = ::Class.new(::TAG)
    tag_class.class_eval { define_method(:name) { name } }
    tag_class
  end
end

class TAG < BasicObject
  def self.valid_tag(tag_name)
    valid_tags(tag_name)
  end

  def self.valid_tags(*tag_names)
    tag_names.each do |tag|
      define_method tag do |attributes = {}, &block|
        tag_class = ::Object.const_get(tag.to_s.upcase)
        eval_block(tag_class.new(attributes), &block)
      end
    end
  end

  def initialize(attributes = {})
    @attributes = attributes
    @children = []
  end

  def str(content)
    @children << ::STR.new(content)
  end

  def eval_block(tag, &block)
    tag.instance_eval(&block)
    @children << tag
  end

  def attributes_to_s
    return '' if @attributes.empty?
    @attributes.each_with_object('') { |(k, v), s| s << %Q( #{attribute_to_html(k)}="#{v}") }
  end

  def attribute_to_html(attr)
    case attr
      when :classes
        'class'
      else
        attr.to_s
    end
  end

  def to_s
    "<#{name}#{attributes_to_s}>#{@children.map(&:to_s).join}</#{name}>"
  end

  def method_missing(method, *_args)
    ::Kernel.raise "#{method} tag is not allowed to be nested within a #{name}"
  end
end
