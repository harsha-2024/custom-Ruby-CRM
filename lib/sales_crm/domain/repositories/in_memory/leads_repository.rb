# frozen_string_literal: true

module SalesCRM
  module Domain
    module Repositories
      module InMemory
        class LeadsRepository
          def initialize
            @by_id = {}
          end
          def create(lead); @by_id[lead.id] = lead; end
          def update(lead); @by_id[lead.id] = lead; end
          def find(id); @by_id[id]; end
          def all; @by_id.values; end
          def delete(id); @by_id.delete(id); end
        end
      end
    end
  end
end
