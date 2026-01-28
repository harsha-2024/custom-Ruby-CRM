# frozen_string_literal: true

module SalesCRM
  module Domain
    module Repositories
      module InMemory
        class QuotesRepository
          def initialize
            @by_id = {}
          end
          def create(q); @by_id[q.id] = q; end
          def update(q); @by_id[q.id] = q; end
          def find(id); @by_id[id]; end
          def all; @by_id.values; end
          def delete(id); @by_id.delete(id); end
        end
      end
    end
  end
end
