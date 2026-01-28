# frozen_string_literal: true

module SalesCRM
  module Domain
    module Services
      class AccountService
        def initialize(accounts_repo:, logger: SalesCRM.logger)
          @accounts = accounts_repo
          @logger = logger
        end

        def create_account(name:, industry: nil, billing_address: nil, shipping_address: nil, owner_id: nil)
          acc = Entities::Account.new(id: Utils::UUID.v4, name: name, industry: industry, billing_address: billing_address, shipping_address: shipping_address, owner_id: owner_id)
          @accounts.create(acc)
          @logger.info("account: created #{acc.id} #{acc.name}")
          acc
        end

        def update_account(account)
          @accounts.update(account)
          account
        end

        def find(id)
          @accounts.find(id)
        end
      end
    end
  end
end
