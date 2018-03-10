Dir[File.expand_path('../tags/*.rb', __FILE__)].each { |f| require f }

class HTML
  def self.document(&block)
    document = Document.new
    document.instance_eval(&block)
    document.to_s
  end
end
