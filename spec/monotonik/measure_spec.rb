# frozen_string_literal: true

RSpec.describe Monotonik::Measure do
  let(:instance) { described_class.new(clock_time: stubbed_clock_time) }

  let(:stubbed_clock_time) do
    clock_time_klass = Struct.new(:start, :finish, :calls_count, :units) do
      def now(unit)
        increase_calls_count!
        store_unit!(unit)

        calls_count.odd? ? start : finish
      end

      private

      def increase_calls_count!
        self.calls_count += 1
      end

      def store_unit!(unit)
        units << unit
      end
    end

    clock_time_klass.new(start, finish, 0, [])
  end

  let(:start) { 0.0 }
  let(:finish) { 0.0 }

  describe '#call' do
    context 'when no block given' do
      it 'raises ArgumentError and does not call ' do
        expect(stubbed_clock_time).not_to receive(:now)

        expect { instance.call }.to raise_error(ArgumentError, 'No block given.')

        expect(stubbed_clock_time.calls_count).to eq(0)
      end
    end

    context 'when block is given' do
      let(:start) { 10.0 }
      let(:finish) { 13.5 }

      let(:block_to_measure) do
        -> { :stubbed_result }
      end

      context "when 'unit' is not specified" do
        it "returns result of block execution and elapsed time in 'float_seconds' format" do
          result = instance.call(&block_to_measure)

          expect(result.value).to eq(:stubbed_result)
          expect(result.time).to eq(finish - start)

          expect(stubbed_clock_time.calls_count).to eq(2)
          expect(stubbed_clock_time.units).to eq(Array.new(2) { Monotonik::TimeUnits::FLOAT_SECOND })
        end
      end

      context "when 'unit' is specified" do
        %i[float_second float_millisecond float_microsecond second millisecond microsecond nanosecond].each do |unit|
          context "when 'unit' is set to ':#{unit}'" do
            it "returns result of block execution and elapsed time in '#{unit}' format" do
              result = instance.call(unit, &block_to_measure)

              expect(result.value).to eq(:stubbed_result)
              expect(result.time).to eq(finish - start)

              expect(stubbed_clock_time.calls_count).to eq(2)
              expect(stubbed_clock_time.units).to eq(Array.new(2) { unit })
            end
          end
        end
      end
    end
  end
end
