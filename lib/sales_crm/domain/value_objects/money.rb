# frozen_string_literal: true

module SalesCRM
  module Domain
    module ValueObjects
      class Money
        attr_reader :amount_cents, :currency
        def initialize(amount_cents, currency: 'USD')
          raise ArgumentError, 'amount_cents must be Integer' unless amount_cents.is_a?(Integer)
          @amount_cents = amount_cents
          @currency = currency
        end
        def +(other)
          raise ArgumentError, 'currency mismatch' unless other.currency == @currency
          Money.new(@amount_cents + other.amount_cents, currency: @currency)
        end
        def -(other)
          raise ArgumentError, 'currency mismatch' unless other.currency == @currency
          Money.new(@amount_cents - other.amount_cents, currency: @currency)
        end
        def *(n)
          Money.new((@amount_cents * n).round, currency: @currency)
        end
        def to_s
          format('%.2f %s', @amount_cents / 100.0, @currency)
        end
        def self.zero(currency: 'USD')
          Money.new(0, currency: currency)
        end
      end
    end
  end
end
