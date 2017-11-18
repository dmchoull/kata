require 'rspec'
require 'rspec/its'
Dir[File.expand_path('../../lib/*.rb', __FILE__)].each { |f| require f }

$TEST = true

RSpec.configure do |config|
  config.before do
    $window = instance_double(GameWindow).as_null_object
    allow(Gosu::Image).to receive(:[]) { |file| Gosu::Image.new("media/#{file}") }
  end
end