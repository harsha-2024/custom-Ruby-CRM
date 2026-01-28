# frozen_string_literal: true

module SalesCRM
  module Domain
    module Repositories
      module InMemory
        class AccountsRepository
          def initialize
            @by_id = {}
          end
          def create(account); @by_id[account.id] = account; end
          def update(account); @by_id[account.id] = account; end
          def find(id); @by_id[id]; end
          def all; @by_id.values; end
          def delete(id); @by_id.delete(id); end
        end
      end
    end
  end
end
