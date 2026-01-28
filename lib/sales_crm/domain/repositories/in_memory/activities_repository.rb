# frozen_string_literal: true

module SalesCRM
  module Domain
    module Repositories
      module InMemory
        class ActivitiesRepository
          def initialize
            @by_id = {}
          end
          def create(a); @by_id[a.id] = a; end
          def update(a); @by_id[a.id] = a; end
          def find(id); @by_id[id]; end
          def all; @by_id.values; end
          def for_related(type, id)
            @by_id.values.select { |a| a.related_type == type && a.related_id == id }
          end
          def delete(id); @by_id.delete(id); end
        end
      end
    end
  end
end
