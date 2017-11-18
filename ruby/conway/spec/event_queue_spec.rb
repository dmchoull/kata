require 'spec_helper.rb'

describe EventQueue do
  subject(:queue) { EventQueue.new }

  describe '#subscribe' do
    it 'should add a listener' do
      listener = double(:listener)
      queue.subscribe(listener)

      expect(queue.listeners).to include(listener)
    end
  end

  describe '#enq' do
    it 'should queue events' do
      event1 = double(:event1)
      event2 = double(:event2)
      queue.enq(event1)
      queue.enq(event2)

      expect(queue.pop).to eq(event1)
      expect(queue.pop).to eq(event2)
    end
  end

  describe '#drain' do
    it 'should notify the listeners of each event in the queue' do
      listener = double(:listener)
      queue.subscribe(listener)

      event1 = double(:event1)
      event2 = double(:event2)
      queue.enq(event1)
      queue.enq(event2)

      expect(listener).to receive(:notify).with(event1).ordered
      expect(listener).to receive(:notify).with(event2).ordered

      queue.drain
    end
  end
end
