# frozen_string_literal: true

module SalesCRM
  module Domain
    module Repositories
      module InMemory
        class ContactsRepository
          def initialize
            @by_id = {}
          end
          def create(contact); @by_id[contact.id] = contact; end
          def update(contact); @by_id[contact.id] = contact; end
          def find(id); @by_id[id]; end
          def all; @by_id.values; end
          def delete(id); @by_id.delete(id); end
          def find_by_account(account_id); @by_id.values.select { |c| c.account_id == account_id }; end
        end
      end
    end
  end
end
