# frozen_string_literal: true

module SalesCRM
  module Domain
    module Entities
      class Product
        attr_accessor :id, :sku, :name, :unit_price_cents, :currency
        def initialize(id:, sku:, name:, unit_price_cents:, currency: 'USD')
          @id = id
          @sku = sku
          @name = name
          @unit_price_cents = unit_price_cents
          @currency = currency
        end
      end
    end
  end
end
