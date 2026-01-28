# frozen_string_literal: true

module SalesCRM
  module Domain
    module Repositories
      module InMemory
        class ProductsRepository
          def initialize
            @by_id = {}
            @by_sku = {}
          end
          def create(product); @by_id[product.id] = product; @by_sku[product.sku] = product; end
          def update(product); @by_id[product.id] = product; @by_sku[product.sku] = product; end
          def find(id); @by_id[id]; end
          def find_by_sku(sku); @by_sku[sku]; end
          def all; @by_id.values; end
          def delete(id)
            p = @by_id.delete(id)
            @by_sku.delete(p.sku) if p
          end
        end
      end
    end
  end
end
