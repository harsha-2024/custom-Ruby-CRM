# frozen_string_literal: true

module SalesCRM
  module Domain
    module Entities
      class Quote
        Line = Struct.new(:product_id, :sku, :name, :quantity, :unit_price_cents, :discount_percent, keyword_init: True)
        attr_accessor :id, :opportunity_id, :status, :currency, :lines, :subtotal_cents, :discount_cents, :tax_cents, :total_cents
        def initialize(id:, opportunity_id:, currency: 'USD')
          @id = id
          @opportunity_id = opportunity_id
          @currency = currency
          @status = :draft
          @lines = []
          @subtotal_cents = 0
          @discount_cents = 0
          @tax_cents = 0
          @total_cents = 0
        end
      end
    end
  end
end
