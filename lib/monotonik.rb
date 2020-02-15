# frozen_string_literal: true

# Module to help measure elapsed time the right way.
module Monotonik
  autoload :ClockTime, 'monotonik/clock_time'
  autoload :Measure,   'monotonik/measure'
  autoload :TimeUnits, 'monotonik/clock_time'
  autoload :VERSION,   'monotonik/version'

  module_function

  # @see Monotonik::ClockTime#now
  def clock_time(unit = ClockTime::DEFAULT_TIME_UNIT)
    ClockTime.now(unit)
  end

  # @see Monotonik::Measure#call
  def measure(unit = ClockTime::DEFAULT_TIME_UNIT, &block)
    Measure.call(unit, &block)
  end
end
