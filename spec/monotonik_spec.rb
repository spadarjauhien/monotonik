# frozen_string_literal: true

RSpec.describe Monotonik do
  it 'has a version number' do
    expect(Monotonik::VERSION).not_to be nil
  end

  describe '.clock_time' do
    context "when 'unit' is not specified" do
      it "returns current monotonic clock time in 'float_seconds' format" do
        t1 = Monotonik.clock_time
        t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC, :float_second)

        expect((t2 - t1).round(2)).to eq(0)
      end
    end

    context "when 'unit' is specified" do
      it 'returns current monotonic clock time in specified format' do
        t1 = Monotonik.clock_time(:millisecond)
        t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond)

        expect((t2 - t1).round(-2)).to eq(0)
      end
    end
  end

  describe '.measure' do
    context "when 'unit' is not specified" do
      it "returns result of block execution and elapsed time in 'float_seconds' format" do
        result = described_class.measure { sleep(0.1) && :result }

        expect(result.time.round(1)).to eq(0.1)
        expect(result.value).to eq(:result)
      end
    end

    context "when 'unit' is specified" do
      it 'returns result of block execution and elapsed time in specified format' do
        result = described_class.measure(:millisecond) { sleep(0.1) && :result }

        expect(result.time.round(-2)).to eq(100)
        expect(result.value).to eq(:result)
      end
    end
  end
end
