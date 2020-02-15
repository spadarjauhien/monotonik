# frozen_string_literal: true

require 'singleton'
require 'forwardable'

module Monotonik
  module TimeUnits
    FLOAT_SECOND      = :float_second
    FLOAT_MILLISECOND = :float_millisecond
    FLOAT_MICROSECOND = :float_microsecond
    SECOND            = :second
    MILLISECOND       = :millisecond
    MICROSECOND       = :microsecond
    NANOSECOND        = :nanosecond

    ALL = [FLOAT_SECOND, FLOAT_MILLISECOND, FLOAT_MICROSECOND, SECOND, MILLISECOND, MICROSECOND, NANOSECOND].freeze
  end

  # Class to get monotonic clock time.
  class ClockTime
    include Singleton

    DEFAULT_TIME_UNIT = TimeUnits::FLOAT_SECOND

    class << self
      extend Forwardable

      # @!method now(unit = DEFAULT_TIME_UNIT)
      #   @see Monotonik::ClockTime#now
      def_delegator :instance, :now
    end

    # Returns a monotonic clock time returned by POSIX ::clock_gettime() function.
    #
    # @param unit [Symbol] Specifies a type of the return value, can be any value from `Monotonik::TimeUnits::ALL`.
    #
    # @raise [ArgumentError] When unexpected 'unit' value is given.
    #
    # @return [Float|Integer] A monotonic clock time returned by POSIX ::clock_gettime() function.
    def now(unit = DEFAULT_TIME_UNIT)
      Process.clock_gettime(Process::CLOCK_MONOTONIC, unit)
    end
  end
end
