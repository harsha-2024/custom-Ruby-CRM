# frozen_string_literal: true

module SalesCRM
  module Domain
    module Services
      class ProductService
        def initialize(products_repo:, logger: SalesCRM.logger)
          @products = products_repo
          @logger = logger
        end

        def create_product(sku:, name:, unit_price_cents:, currency: 'USD')
          p = Entities::Product.new(id: Utils::UUID.v4, sku: sku, name: name, unit_price_cents: unit_price_cents, currency: currency)
          @products.create(p)
          @logger.info("product: created #{p.id} #{p.sku} #{p.name}")
          p
        end

        def find_by_sku(sku)
          @products.find_by_sku(sku)
        end
      end
    end
  end
end
