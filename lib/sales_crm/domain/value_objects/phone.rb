# frozen_string_literal: true

module SalesCRM
  module Domain
    module ValueObjects
      class Phone
        attr_reader :value
        def initialize(value)
          # accept digits, +, -, spaces, parentheses
          raise ArgumentError, 'invalid phone' unless value && value.to_s.strip.match(/\A[\d\+\-\s\(\)]+\z/)
          @value = value
        end
        def to_s = @value
      end
    end
  end
end
