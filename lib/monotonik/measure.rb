# frozen_string_literal: true

require 'forwardable'

module Monotonik
  # Class to measure elapsed time.
  class Measure
    Result = Struct.new(:time, :value)

    attr_reader :clock_time

    class << self
      extend Forwardable

      # @return [Monotonik::Measure]
      def instance
        @instance ||= new
      end

      # @!method call(unit = Monotonik::TimeUnits::FLOAT_SECOND)
      #   @see Monotonik::Measure#call
      def_delegator :instance, :call
    end

    def initialize(clock_time: ClockTime)
      @clock_time = clock_time
    end

    # Measure elapsed time while performing the given block.
    #
    # @param unit [Symbol] Specifies a type of the return elapsed time value, can be any value from
    #   `Monotonik::TimeUnits::ALL`.
    #
    # @yield Block to measure elapsed time for.
    #
    # @return [Monotonik::Measure::Result] Elapsed time with result of the given block yield.
    def call(unit = TimeUnits::FLOAT_SECOND)
      raise ArgumentError, 'No block given.' unless block_given?

      start = clock_time.now(unit)
      result = yield
      finish = clock_time.now(unit)

      Result.new(finish - start, result)
    end
  end
end
