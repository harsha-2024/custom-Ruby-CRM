# frozen_string_literal: true

module SalesCRM
  module Domain
    module Repositories
      module InMemory
        class OpportunitiesRepository
          def initialize
            @by_id = {}
          end
          def create(opp); @by_id[opp.id] = opp; end
          def update(opp); @by_id[opp.id] = opp; end
          def find(id); @by_id[id]; end
          def all; @by_id.values; end
          def where_stage(stage)
            @by_id.values.select { |o| o.stage == stage }
          end
          def delete(id); @by_id.delete(id); end
        end
      end
    end
  end
end
