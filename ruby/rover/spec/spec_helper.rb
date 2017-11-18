require 'rspec/its'

Dir[File.expand_path('../../lib/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../support/*.rb', __FILE__)].each { |f| require f }
