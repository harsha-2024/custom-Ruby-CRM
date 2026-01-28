# frozen_string_literal: true

module SalesCRM
  module Domain
    module Services
      class ContactService
        def initialize(contacts_repo:, logger: SalesCRM.logger)
          @contacts = contacts_repo
          @logger = logger
        end

        def create_contact(account_id:, first_name:, last_name:, email: nil, phone: nil, title: nil)
          c = Entities::Contact.new(id: Utils::UUID.v4, account_id: account_id, first_name: first_name, last_name: last_name, email: email, phone: phone, title: title)
          @contacts.create(c)
          @logger.info("contact: created #{c.id} #{c.first_name} #{c.last_name}")
          c
        end
      end
    end
  end
end
