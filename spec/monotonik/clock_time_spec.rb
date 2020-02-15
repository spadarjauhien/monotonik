# frozen_string_literal: true

RSpec.describe Monotonik::ClockTime do
  let(:instance) { described_class.instance }

  describe '#now' do
    context "when 'unit' is not specified" do
      subject { instance.now }

      it "calls 'Process::clock_gettime' with monotonic clock ID and ':float_second' unit and returns its result" do
        expect(Process)
          .to receive(:clock_gettime)
          .with(Process::CLOCK_MONOTONIC, :float_second)
          .and_return(:fake_result)

        is_expected.to eq(:fake_result)
      end
    end

    context "when 'unit' is specified" do
      %i[float_second float_millisecond float_microsecond second millisecond microsecond nanosecond].each do |unit|
        context "when 'unit' is set to ':#{unit}'" do
          subject { instance.now(unit) }

          it "calls 'Process::clock_gettime' with monotonic clock ID and ':#{unit}' unit and returns its result" do
            expect(Process)
              .to receive(:clock_gettime)
              .with(Process::CLOCK_MONOTONIC, unit)
              .and_return(:fake_result)

            is_expected.to eq(:fake_result)
          end
        end
      end

      context "when 'unit' is set to unexpected value" do
        it "raises 'ArgumentError'" do
          expect { instance.now(:hour) }.to raise_error(ArgumentError, 'unexpected unit: hour')
        end
      end
    end
  end
end
